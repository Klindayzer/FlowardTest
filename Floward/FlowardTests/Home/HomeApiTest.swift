//
//  HomeApiTest.swift
//  LevelShoesTests
//
//  Created by Klindayzer on 22/12/2021.
//

import XCTest
@testable import Floward

class HomeApiTest: XCTestCase {

    func testHomeBuildable() {
        
        // Given
        let sut = HomeApi(term: "term", page: 1)
        
        // When
        let url = sut.url
        
        // Then
        XCTAssertEqual(sut.endPoint, .empty)
        XCTAssertEqual(sut.proxy, .empty)
        XCTAssertEqual(sut.version, .empty)
        XCTAssertEqual(sut.parameters!.count, 7)
        XCTAssertEqual(sut.parameters!["apikey"] as! String, "3184d334")
        XCTAssertEqual(sut.parameters!["s"] as! String, "term")
        XCTAssertEqual(sut.parameters!["plot"] as! String, "full")
        XCTAssertEqual(sut.parameters!["type"] as! String, "movie")
        XCTAssertEqual(sut.parameters!["page"] as! Int, 1)
        XCTAssertEqual(sut.parameters!["y"] as! String, "2017")
        XCTAssertEqual(sut.parameters!["v"] as! String, "2")
        XCTAssertEqual(url!.absoluteString, "http://www.omdbapi.com")
    }
}
