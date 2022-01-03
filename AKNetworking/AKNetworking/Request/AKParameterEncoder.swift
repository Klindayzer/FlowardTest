/*
 *	AKParameterEncoder.swift
 *	AKNetworking
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import Foundation

protocol AKParameterEncoder {
    func encode(urlRequest: URLRequest, with parameters: RequestParameters?) throws -> URLRequest
}

struct AKURLEncoder: AKParameterEncoder {
    
    func encode(urlRequest: URLRequest, with parameters: RequestParameters?) throws -> URLRequest {
        
        guard let parameters = parameters else {
            return urlRequest
        }

        var urlRequest = urlRequest
        guard let url = urlRequest.url else { throw URLError.urlMalformatted }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        return urlRequest
    }
}

struct AKJSONEncoder: AKParameterEncoder {
    
    func encode(urlRequest: URLRequest, with parameters: RequestParameters?) throws -> URLRequest {
        
        guard let parameters = parameters else {
            return urlRequest
        }
        
        do {
            var urlRequest = urlRequest
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            return urlRequest
        } catch {
            throw URLRequestError.encodingFailed
        }
    }
}
