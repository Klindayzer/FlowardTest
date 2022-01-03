/*
 *	AKClientContractor.swift
 *	AKNetworking
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */

public protocol AKClientContractor {
    
    func request<T: AKResultable>(buildable: AKBuildable, type: T.Type, completion: @escaping (ServiceResult<T>) -> Void)
    func cancel()
}
