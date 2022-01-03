//
//  StringTest.swift
//  LevelShoesTests
//
//  Created by Klindayzer on 21/12/2021.
//

import XCTest
@testable import Floward

class StringTest: XCTestCase {

    func testEmptyStringValue() {
        
        // Given
        let sut: String = .empty
        
        // When
        let emptyString = ""
        
        // Then
        XCTAssertEqual(sut, emptyString)
    }
}
