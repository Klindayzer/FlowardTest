//
//  HomeViewController.swift
//  Floward
//
//  Created by Klindayzer on 02/01/2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Definitions
    private enum Values {
        
        static let numberOfitemsInRow: CGFloat = 2
        static let itemSpacing: CGFloat = 16
        static let cellHeight: CGFloat = 180
    }
    
    // MARK: - Protucted Properties
    weak var searchTextField: UITextField?
    weak var collectionView: UICollectionView?
    private var viewModel = HomeViewModel()
    private var isWating = false
    
    // MARK: - Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemFill
        
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Protucted Methods
    private func search(term: String, freshTerm: Bool = true) {
        
        showLoader()
        viewModel.search(for: term) { [weak self] success, error in
            
            defer {
                self?.isWating = false
                self?.hideLoader()
            }
            
            success ? self?.handleSuccessResponse(freshTerm) : self?.handleFailureResponse(error: error)
        }
    }
    
    private func handleSuccessResponse(_ freshTerm: Bool) {
        
        collectionView?.reloadData()
        if freshTerm, viewModel.itemsCount > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .top, animated: false)
        }
    }
    
    private func handleFailureResponse(error: String) {
        
        let alert = UIAlertController(title: "Ops!", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func checkTermAndSerach() {
        
        view.endEditing(true)
        guard let term = viewModel.validateSearchTerm(searchTextField?.text) else { return }
        viewModel.currentPage = 1
        search(term: term)
    }
    
    private func loadMore() {
        
        guard let term = viewModel.validateSearchTerm(searchTextField?.text), viewModel.shouldLoadMore else { return }
        isWating = true
        viewModel.currentPage += 1
        search(term: term, freshTerm: false)
    }
    
    // MARK: - Selectors
    @objc
    func searchClicked() {
        checkTermAndSerach()
    }
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        checkTermAndSerach()
        return true
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let item = viewModel.item(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        let cell: MovieCell = collectionView.dequeue(for: indexPath)
        cell.setup(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel.itemsCount - 2 && !isWating {
            loadMore()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let fullWidth = collectionView.bounds.width
        let inset = Values.itemSpacing
        let itemWidth = (fullWidth - inset) / Values.numberOfitemsInRow
        return CGSize(width: itemWidth, height: Values.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        view.endEditing(true)
    }
}
