/*
 *	MovieCell.swift
 *	Floward
 *
 *	Created by Klindayzer on 03/01/2022.
 *	Copyright 2022 ___ORGANIZATIONNAME___. All rights reserved.
 */

import UIKit

final class MovieCell: UICollectionViewCell {
    
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
        
        let posterImage = createPosterImageView()
        contentView.addSubview(posterImage)
        
        let shadowImage = createTitleLabel()
        contentView.addSubview(shadowImage)
        
        let titleLabel = createTitleLabel()
        contentView.addSubview(titleLabel)
        
        contentView.backgroundColor = .white
        contentView.setNeedsLayout()
    }
    
    private func createPosterImageView() -> UIImageView {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        self.imageView = imageView
        return imageView
    }
    
    private func createShadowImageView() -> UIImageView {
        
        let imageView = UIImageView(image: UIImage(named: "shadow1"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        return imageView
    }
    
    private func createTitleLabel() -> UILabel {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        return label
    }
}
