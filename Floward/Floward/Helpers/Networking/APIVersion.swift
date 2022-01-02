/*
 *	APIVersion.swift
 *	LevelShoes
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

enum APIVersion {
    
    case v1
    case v2
    case v3
    
    var value: String {
        switch self {
        case .v1:
            return "v1"
        case .v2:
            return "v2"
        case .v3:
            return "v3"
        }
    }
}
