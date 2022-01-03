/*
 *	HomeViewController+UI.swift
 *	Floward
 *
 *	Created by Klindayzer on 03/01/2022.
 *	Copyright 2022 ___ORGANIZATIONNAME___. All rights reserved.
 */

import UIKit

// MARK: - Definitions
private enum Values {
    static let spacing: CGFloat = 16
    static let cornerRadius: CGFloat = 8
}

extension HomeViewController {

    // MARK: - Exposed Methods
    func setupUI() {
        
        setupSearchBar()
        setupCollectionView()
        
        view.setNeedsLayout()
    }
    
    // MARK: - Protucted Methods
    private func setupSearchBar() {
        
        // Creat search button
        let button = createSearchButton()
        view.addSubview(button)
        
        // Create search text filed
        let textField = createSearchTextField()
        view.addSubview(textField)
        
        let margins = view.layoutMarginsGuide
        
        // Set button constraints
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            button.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
        
        // Set textfield constraints
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: margins.topAnchor),
            textField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -Values.spacing)
        ])
        
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupCollectionView() {
        
        guard let textField = searchTextField else { return }
        
        // Create collection view
        let collectionView = createCollectionView()
        view.addSubview(collectionView)
        
        // Set collectionview constraints
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Values.spacing),
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])        
    }
    
    private func createSearchButton() -> UIButton {
        
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func createSearchTextField() -> UITextField {
        
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Search for a movie", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.returnKeyType = .search
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.layer.cornerRadius = Values.cornerRadius
        textField.clipsToBounds = true
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField = textField
        return textField
    }
    
    private func createCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemFill
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.name)
        collectionView.dataSource = self        
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView = collectionView
        return collectionView
    }
}
