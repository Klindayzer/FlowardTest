//
//  HomeViewModelTest.swift
//  LevelShoesTests
//
//  Created by Klindayzer on 22/12/2021.
//

import XCTest
@testable import Floward

class HomeViewModelTest: XCTestCase {

    func testWhenFethcingMoviesSuccess() {
        
        // Given
        let client = MockClient(mockFile: "HomeMock")
        let viewModel = HomeViewModel(apiClient: client)
        
        // When
        viewModel.search(for: "term") { _, _ in }
        
        // Then
        XCTAssertTrue(viewModel.shouldLoadMore)
        XCTAssertEqual(viewModel.totalResults, 29)
        XCTAssertEqual(viewModel.itemsCount, 10)
        XCTAssertNotNil(viewModel.item(at: 0))
        XCTAssertNil(viewModel.item(at: 100))
    }
    
    func testWhenFethcingMoviesWithOnePageSuccess() {
        
        // Given
        let client = MockClient(mockFile: "HomeMockOnePage")
        let viewModel = HomeViewModel(apiClient: client)
        
        // When
        viewModel.search(for: "term") { _, _ in }
        
        // Then
        XCTAssertFalse(viewModel.shouldLoadMore)
        XCTAssertEqual(viewModel.totalResults, 1)
        XCTAssertEqual(viewModel.itemsCount, 1)
        XCTAssertNotNil(viewModel.item(at: 0))
        XCTAssertNil(viewModel.item(at: 100))
    }
    
    func testWhenFethcingMoviesFailed() {
        
        // Given
        let client = MockClient(mockFile: "HomeMockFailure")
        let viewModel = HomeViewModel(apiClient: client)
        
        // When
        var errorMessage: String = .empty
        viewModel.search(for: "term") { success, error in
            errorMessage = error
        }
        
        // Then
        XCTAssertFalse(viewModel.shouldLoadMore)
        XCTAssertEqual(viewModel.totalResults, 0)
        XCTAssertEqual(viewModel.itemsCount, 0)
        XCTAssertNil(viewModel.item(at: 0))
        XCTAssertEqual(errorMessage, "Invalid API key!")
    }
    
    func testGetMovieByIndex() {
        
        // Given
        let client = MockClient(mockFile: "HomeMock")
        let viewModel = HomeViewModel(apiClient: client)
        
        // When
        viewModel.search(for: "term") { _, _ in }
        let movie: MoviePresentable! = viewModel.item(at: 0)
        
        // Then
        XCTAssertEqual(movie.title, "Artist Profile: Adam Mizner")
        XCTAssertEqual(movie.poster, "https://m.media-amazon.com/images/M/MV5BOTM0ZDE0YzgtOWI3Zi00YTM0LWE1N2EtYTZlZDhkZTQ0OTQ3XkEyXkFqcGdeQXVyNjI5NjYyNjU@._V1_SX300.jpg")
    }
    
    func testValidateSearchTerm() {
        
        // Given
        let viewModel = HomeViewModel()
        let term1 = "Term1"
        let term2 = "  Term2  "
        let term3: String = .empty
        let term4: String? = nil
        
        
        // When
        let term1Validated = viewModel.validateSearchTerm(term1)
        let term2Validated = viewModel.validateSearchTerm(term2)
        let term3Validated = viewModel.validateSearchTerm(term3)
        let term4Validated = viewModel.validateSearchTerm(term4)
        
        // Then
        XCTAssertEqual(term1Validated, "Term1")
        XCTAssertEqual(term2Validated, "Term2")
        XCTAssertNil(term3Validated)
        XCTAssertNil(term4Validated)
    }
}
