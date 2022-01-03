/*
 *	MockClient.swift
 *	AKNetworking
 *
 *	Created by Klindayzer on 22/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import AKNetworking

public enum MockError: Error {
    case mockFileNotFound
    case mockInitializeData
    
    var value: String {
        switch self {
        case .mockFileNotFound:
            return "Json file not found"
        case .mockInitializeData:
            return "Json with wrong formate"
        }
    }
}

public class MockClient: AKClientContractor {
    
    // MARK: - Properties
    let mockFile: String
    
    // MARK: - Constructors
    init(mockFile: String) {
        self.mockFile = mockFile
    }
    
    // MARK: - Exposed Methods
    public func request<T>(buildable: AKBuildable, type: T.Type, completion: @escaping (ServiceResult<T>) -> Void) where T : AKResultable {
        
        if let path = Bundle(for: MockClient.self).path(forResource: mockFile, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion(T.result(responseData: data, response: nil))
                
            } catch {
                completion(.failure(ServiceError(error: MockError.mockInitializeData.value)))
                return
            }
        } else {
            completion(.failure(ServiceError(error: MockError.mockFileNotFound.value)))
        }
    }
    
    public func cancel() {}
}
