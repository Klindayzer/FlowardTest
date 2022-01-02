/*
 *	AKFetchable.swift
 *	AKNetworking
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import Foundation

// MARK: - Types
typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol AKFetchableContractor {
    
    var task: URLSessionTask? { get set }
    func fetch(_ request: URLRequest, completion: @escaping NetworkCompletion)
}

final class AKFetchable: AKFetchableContractor {
    
    var task: URLSessionTask?
    
    func fetch(_ request: URLRequest, completion: @escaping NetworkCompletion) {
        
        let session = URLSession.shared
        task = session.dataTask(with: request, completionHandler: { data, response, error in
            completion(data, response, error)
        })
        task?.resume()
    }
}
