/*
 *	MockBuildable.swift
 *	LevelShoes
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import AKNetworking
@testable import Floward

struct MockBuildable: APIBuildable {
    
    // MARK: - Definitions
    enum Service {
        case api_1
        case api_2
        case api_3
    }
    
    // MARK: - Properties
    let service: Service
    
    // MARK: - Constructors
    init(service: Service) {
        self.service = service
    }
    
    // MARK: - Implementation Methods
    var endPoint: String {
        
        switch service {
        case .api_1:
            return "service_1"
        case .api_2:
            return "service_2"
        case .api_3:
            return "service_3"
        }
    }
    
    var proxy: String {
        
        switch service {
        case .api_1:
            return "proxy_1"
        case .api_2:
            return "proxy_2"
        case .api_3:
            return "proxy_3"
        }
    }
    
    var version: String {
        
        switch service {
        case .api_1:
            return "v1"
        case .api_2:
            return "v2"
        case .api_3:
            return "v3"
        }
    }
    
    var parameters: RequestParameters? {
        
        switch service {
        case .api_1:
            return ["param1": "P1"]
        case .api_2:
            return ["param1": "P1", "param2": "P2"]
        case .api_3:
            return nil
        }
    }
}
