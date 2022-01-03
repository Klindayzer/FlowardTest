/*
 *	Collection.swift
 *	LevelShoes
 *
 *	Created by Klindayzer on 22/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import Foundation

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
