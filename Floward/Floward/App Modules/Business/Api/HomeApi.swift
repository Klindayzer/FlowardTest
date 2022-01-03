/*
 *	HomeApi.swift
 *	LevelShoes
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import AKNetworking
import MapKit

struct HomeApi: APIBuildable {
    
    private let term: String
    private let page: Int
    
    init(term: String, page: Int) {
        
        self.term = term
        self.page = page
    }
    
    var proxy: String  = .empty
    
    var endPoint: String = .empty
    
    var version: String = .empty
    
    var parameters: RequestParameters? {
        
        // All paramaters should ne injected, but for since it's dummy api am harcoding the values
        return [
            "apikey":Environment.shared.getValue(for: .apiKey),
            "s": term,
            "plot": "full",
            "type": "movie",
            "page": page,
            "y":"2017",
            "v": "2"
        ]
    }
}
