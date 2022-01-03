//
//  EnvironmentTest.swift
//  LevelShoesTests
//
//  Created by Klindayzer on 21/12/2021.
//

import XCTest
@testable import Floward

class EnvironmentTest: XCTestCase {

    func testIsDebugWhenDevelopScheme() {
        
        // Given
        let sut = Environment.shared.isDebug
        
        // Then
        XCTAssertTrue(sut)
    }
    
    func testBaseApiUrl() {
        
        // Given
        let sut = Environment.shared.getValue(for: .apiBaseUrl)
        
        // When
        let baseUrl = "http://www.omdbapi.com"
        
        // Then
        XCTAssertEqual(sut, baseUrl)
    }
    
    func testApiKey() {
        
        // Given
        let sut = Environment.shared.getValue(for: .apiKey)
        
        // When
        let baseUrl = "3184d334"
        
        // Then
        XCTAssertEqual(sut, baseUrl)
    }
}
