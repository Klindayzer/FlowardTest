/*
 *	AKErrors.swift
 *	AKNetworking
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

private extension String {
    
    static let invalidURL = "URL is not valid"
    static let unableToDecode = "We could not decode the response."
    static let dataUnavailable = "Response returned with no data to decode."
    static let noNetwork = "An error occured while getting ios network"
}

enum NetworkError: Error {
    
    case noData
    case noNetwork
    
    var value: String {
        
        switch self {
        case .noData: return .dataUnavailable
        case .noNetwork: return .noNetwork
        }
    }
}

enum URLError: Error {
    
    case urlMalformatted
    
    var value: String {
        switch self {
        case .urlMalformatted: return .invalidURL
        }
    }
}

enum URLRequestError: Error {
    
    case encodingFailed
    
    var value: String {
        switch self {
        case .encodingFailed: return .unableToDecode
        }
    }
}
