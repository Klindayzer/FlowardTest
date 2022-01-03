/*
 *	MovieCell.swift
 *	Floward
 *
 *	Created by Klindayzer on 03/01/2022.
 *	Copyright 2022 ___ORGANIZATIONNAME___. All rights reserved.
 */

import UIKit

final class MovieCell: UICollectionViewCell {
    
    // MARK: - Definitions
    private enum Values {
        static let spacing: CGFloat = 16
        static let fontSize: CGFloat = 16
        static let titleMaxLines = 2
        static let cornerRadius: CGFloat = 8
        static let titleViewHeight: CGFloat = 50
    }

    // MARK: - Properties
    private weak var imageView: UIImageView?
    private weak var label: UILabel?
    
    // MARK: - Exposed Methods
    func setup(with movie: MoviePresentable) {
     
        setupUI()
        
        imageView?.setImage(url: movie.poster)
        label?.text = movie.title
    }
    
    // MARK: - Protected Methods
    private func setupUI() {
                
        setupContentView()
        
        // Create poster image view
        let posterImage = createPosterImageView()
        contentView.addSubview(posterImage)
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // Create title shadow image view
        let shadowView = createShadowView()
        contentView.addSubview(shadowView)
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shadowView.heightAnchor.constraint(equalToConstant: Values.titleViewHeight)
        ])
        
        // Create title label
        let titleLabel = createTitleLabel()
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Values.spacing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Values.spacing),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Values.titleViewHeight)
        ])
        
        contentView.setNeedsLayout()
    }
    
    private func setupContentView() {
        
        contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
        contentView.backgroundColor = .clear
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray.cgColor
        contentView.layer.cornerRadius = Values.cornerRadius
        contentView.clipsToBounds = true
    }
    
    private func createPosterImageView() -> UIImageView {
        
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
                
        self.imageView = imageView
        return imageView
    }
    
    private func createShadowView() -> UIView {
        
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    private func createTitleLabel() -> UILabel {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Values.fontSize)
        label.textColor = .white
        label.numberOfLines = Values.titleMaxLines
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.label = label
        return label
    }
}
