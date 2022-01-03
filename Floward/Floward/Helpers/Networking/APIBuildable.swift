/*
 *	APIBuildable.swift
 *	LevelShoes
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import AKNetworking

protocol APIBuildable: AKBuildable {
    var baseURL: String? { get }
}

// MARK: - Default values
extension APIBuildable {
    
    var method: RequestMethod { .get }
    var encoding: RequestEncoding { .url }
    var timeout: RequestTimeout { .sixty }
    var headers: RequestHeaders? { nil }
}

// MARK: - Computed values
extension APIBuildable {
    
    var baseURL: String? {
        Environment.shared.getValue(for: .apiBaseUrl)
    }
    
    var url: URL? {
        
        guard let baseURL = baseURL,
              var url = URL(string: baseURL) else { return nil }
        
        if !version.isEmpty {
            url = url.appendingPathComponent(version)
        }
        
        if !proxy.isEmpty {
            url = url.appendingPathComponent(proxy)
        }
        
        if !endPoint.isEmpty {
            url = url.appendingPathComponent(endPoint)
        }
        return url
    }
}
