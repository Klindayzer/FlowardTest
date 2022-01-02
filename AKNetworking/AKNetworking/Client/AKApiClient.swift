/*
 *	AKApiClient.swift
 *	AKNetworking
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import Foundation

public final class AKApiClient: AKClientContractor, AKReachability, AKLogger {
    
    // MARK: - Properties
    var fetchable: AKFetchableContractor = AKFetchable()
    
    // MARK: - Computed Properties
    var shouldLog: Bool {
        AKNetworkInitializer.shared.isDebug
    }
    
    // MARK: - Constructors
    public init() {}
    
    // MARK: - Exposed Methods
    public func request<T>(buildable: AKBuildable, type: T.Type, completion: @escaping (ServiceResult<T>) -> Void) where T : AKResultable {
        
        do {
            let request = try buildable.asURLRequest()
            logRequest(request)
            fetchRequest(request, completion: completion)
            
        } catch let exception {
            logError(exception)
            completion(.failure(ServiceError(error: exception.localizedDescription)))
        }
    }
    
    public func cancel() {
        fetchable.task?.cancel()
    }
    
    // MARK: - Protected Methods
    private func fetchRequest<T>(_ request: URLRequest, completion: @escaping (ServiceResult<T>) -> Void) where T : AKResultable {
        
        guard isConnectedToNetwork else {
            completion(.failure(ServiceError(error: NetworkError.noNetwork.value, statusCode: 1111)))
            return
        }

        DispatchQueue.global(qos: .background).async {
            
            self.fetchable.fetch(request) { data, response, error in
                
                DispatchQueue.main.sync {
                    let response = response as? HTTPURLResponse
                    self.logResponse(response, data: data, error: error)
                    
                    guard let responseData = data, response != nil else {
                        completion(.failure(ServiceError(error: NetworkError.noData.value)))
                        return
                    }
                    
                    completion(T.result(responseData: responseData, response: response))
                }
            }
        }
    }
}
