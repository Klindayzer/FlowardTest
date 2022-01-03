/*
 *	AKBuildable.swift
 *	AKNetworking
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

// MARK: - Type
public typealias RequestHeaders = [String: String]
public typealias RequestParameters = [String: Any]

// MARK: - Definitions
public enum RequestMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum RequestEncoding {
    case json
    case url
}

public enum RequestTimeout: Int {
    
    case fifteen = 15
    case thirty = 30
    case sixty = 60
    case ninty = 90
}

public protocol AKBuildable {
    
    var url: URL? { get }
    var proxy: String { get }
    var endPoint: String { get }
    var method: RequestMethod { get }
    var encoding: RequestEncoding { get }
    var timeout: RequestTimeout { get }
    var version: String { get }
    var headers: RequestHeaders? { get }
    var parameters: RequestParameters? { get }    
}

private extension AKBuildable {
    
    var parameterEncoding: AKParameterEncoder {

        switch encoding {
        case .json:
            return AKJSONEncoder()
        case .url:
            return AKURLEncoder()
        }
    }
    
    var timeoutInterval: TimeInterval {
        TimeInterval(timeout.rawValue)
    }
}

extension AKBuildable {
    
    func asURLRequest() throws -> URLRequest {
        
        guard let url = url else {
            throw URLError.urlMalformatted
        }
                
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeoutInterval)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        do {
            return try parameterEncoding.encode(urlRequest: request, with: parameters)        
        } catch {
            throw URLRequestError.encodingFailed
        }
    }
}
