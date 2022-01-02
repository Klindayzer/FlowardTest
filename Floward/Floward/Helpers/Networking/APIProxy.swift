/*
 *	APIProxy.swift
 *	LevelShoes
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

enum APIProxy {

  case home
    
    var value: String {
        switch self {
        case .home:
            return "5c138271-d8dd-4112-8fb4-3adb1b7f689e"
        }
    }
}
