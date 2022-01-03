/*
 *	UIImageView.swift
 *	LevelShoes
 *
 *	Created by Klindayzer on 22/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(url: String?) {
        
        let url = URL(string: url ?? .empty)
        KF.url(url)
            .placeholder(UIImage(named: "placeholder"))
            .loadDiskFileSynchronously()
            .fade(duration: 0.25)
            .set(to: self)
    }
}
