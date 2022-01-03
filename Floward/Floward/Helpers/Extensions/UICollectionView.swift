/*
 *	UICollectionView.swift
 *	LevelShoes
 *
 *	Created by Klindayzer on 22/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import UIKit

extension UICollectionView {
    
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.name, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Collection View Cell With Id \(T.name)")
        }
        return cell
    }
}
