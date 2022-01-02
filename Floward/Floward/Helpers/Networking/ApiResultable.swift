/*
 *	ApiResultable.swift
 *	LevelShoes
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

import AKNetworking

typealias APICallback = (_ success: Bool, _ error: String) -> Void

protocol ApiResultable: AKResultable {}

extension ApiResultable {
    
    func result() -> ServiceResult<Self> {
        return .success(self)
    }
    
    static func result<T>(responseData: Data, response: HTTPURLResponse?) -> ServiceResult<T> where T : AKResultable {
        
        do {
            let object = try JSONDecoder().decode(T.self, from: responseData)
            return object.result()
            
        } catch let exception {
            return .failure(ServiceError(error: exception.localizedDescription))
        }
    }
}
