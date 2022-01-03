/*
 *	AKResultable.swift
 *	AKNetworking
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import Foundation

// MARK: - Definitions
public enum ServiceResult<T: Codable> {
    case success(T)
    case failure(ServiceError)
}

public protocol AKResultable: Codable {
    
    func result() -> ServiceResult<Self>
    static func result<T: AKResultable>(responseData: Data, response: HTTPURLResponse?) -> ServiceResult<T>
}

public struct ServiceError: Error {
    
    public let error: String
    public let statusCode: Int
    public let errorCode: String?
    public let reason: String?
    public let subject: String?
    
    public init(error: String?, errorCode: String? = nil, statusCode: Int? = 0, reason: String? = nil, subject: String? = nil) {
        
        self.error = error ?? .unknown
        self.statusCode = statusCode ?? 0
        self.errorCode = errorCode
        self.reason = reason
        self.subject = subject
    }
}

private extension String {
    static let unknown = "unknown"
}
