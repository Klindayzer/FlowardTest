/*
 *	AKFetchable.swift
 *	AKNetworking
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import Foundation

// MARK: - Types
public typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

public protocol AKFetchableContractor {
    
    var task: URLSessionTask? { get set }
    func fetch(_ request: URLRequest, completion: @escaping NetworkCompletion)
}

public final class AKFetchable: AKFetchableContractor {
    
    public var task: URLSessionTask?
    
    public init() {}
    
    public func fetch(_ request: URLRequest, completion: @escaping NetworkCompletion) {
        
        let session = URLSession.shared
        task = session.dataTask(with: request, completionHandler: { data, response, error in
            completion(data, response, error)
        })
        task?.resume()
    }
}
