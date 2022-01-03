//
//  NetworkingTest.swift
//  LevelShoesTests
//
//  Created by Klindayzer on 21/12/2021.
//

import XCTest
@testable import Floward

class NetworkingTest: XCTestCase {

    func testService1() {
        
        // Given
        let sut = MockBuildable(service: .api_1)
        
        // When
        let url = sut.url
        
        // Then
        XCTAssertEqual(sut.endPoint, "service_1")
        XCTAssertEqual(sut.proxy, "proxy_1")
        XCTAssertEqual(sut.version, "v1")
        XCTAssertEqual(sut.parameters?.count, 1)
        XCTAssertEqual(url?.absoluteString, "http://www.omdbapi.com/v1/proxy_1/service_1")
    }
    
    func testService2() {
        
        // Given
        let sut = MockBuildable(service: .api_2)
        
        // When
        let url = sut.url
        
        // Then
        XCTAssertEqual(sut.endPoint, "service_2")
        XCTAssertEqual(sut.proxy, "proxy_2")
        XCTAssertEqual(sut.version, "v2")
        XCTAssertEqual(sut.parameters?.count, 2)
        XCTAssertEqual(url?.absoluteString, "http://www.omdbapi.com/v2/proxy_2/service_2")
    }
    
    func testService3() {
        
        // Given
        let sut = MockBuildable(service: .api_3)
        
        // When
        let url = sut.url
        
        // Then
        XCTAssertEqual(sut.endPoint, "service_3")
        XCTAssertEqual(sut.proxy, "proxy_3")
        XCTAssertEqual(sut.version, "v3")
        XCTAssertNil(sut.parameters)
        XCTAssertEqual(url?.absoluteString, "http://www.omdbapi.com/v3/proxy_3/service_3")
    }
}
