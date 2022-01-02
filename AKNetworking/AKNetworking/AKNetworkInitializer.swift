/*
 *	AKNetworkInitializer.swift
 *	AKNetworking
 *
 *	Created by Klindayzer on 21/12/2021.
 *	Copyright 2021 ___ORGANIZATIONNAME___. All rights reserved.
 */


public final class AKNetworkInitializer {

    // MARK: - Exposed Properties
    public static let shared = AKNetworkInitializer()
    
    // MARK: - Protected Properties
    var isDebug: Bool
    
    // MARK: - Constructors
    private init() {
        isDebug = false
    }
    
    // MARK: - Exposed Methods
    public func configure(isDebug: Bool) {
        self.isDebug = isDebug        
    }
}
