/*
 *	UIViewController.swift
 *	LevelShoes
 *
 *	Created by Klindayzer on 22/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showLoader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hideLoader() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
