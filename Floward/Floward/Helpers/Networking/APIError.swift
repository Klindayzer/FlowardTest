/*
 *	APIError.swift
 *	Floward
 *
 *	Created by Klindayzer on 03/01/2022.
 *	Copyright 2022 ___ORGANIZATIONNAME___. All rights reserved.
 */

struct APIError: ApiResultable {
    
    let response, error: String?

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case error = "Error"
    }
}
