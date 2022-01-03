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
    private var viewModel = HomeViewModel()
    weak var searchTextField: UITextField?
    weak var collectionView: UICollectionView?
    
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
    private func search(term: String) {
        
        showLoader()
        viewModel.search(for: term) { [weak self] success, error in
            
            defer {
                self?.hideLoader()
            }
            
            success ? self?.collectionView?.reloadData() : self?.handleFailureResponse(error: error)
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
        search(term: term)
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
