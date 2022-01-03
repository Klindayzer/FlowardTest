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
        static let cellHeight: CGFloat = 250
    }
    
    // MARK: - Protucted Properties
    weak var searchTextField: UITextField?
    weak var collectionView: UICollectionView?
    
    // MARK: - Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    // MARK: - Selectors
    @objc
    func searchClicked() {
        
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
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
    }
}
