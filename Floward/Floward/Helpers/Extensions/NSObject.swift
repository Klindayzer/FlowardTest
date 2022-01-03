/*
 *	NSObject.swift
 *	LevelShoes
 *
 *	Created by Klindayzer on 22/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import Foundation

extension NSObject {
    
    static var name: String {
        return String(describing: self)
    }
}
