//
//  MovieDatabaseClientTests.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import Foundation
import XCTest
@testable import Premier

class MovieDatabaseClientTests: XCTestCase {
    
    private let client = MovieDatabaseClient.shared
    
    // MARK: - Setup
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    // MARK: - Tests
    
    func testTopRatedMovies() {
        let e = expectation(description: "top rated movies")
        
        Stubber.stubTopRatedPage1()
        
        let request = TopRatedMoviesRequest(page: 1)
        client.execute(request) { (response: Response<PaginatedResponse<Movie>>) in
            switch response.result {
            case .success(let value):
                XCTAssertNotEqual(0, value.results?.count, "Failed to map movies")
                XCTAssertEqual(20, value.results?.count, "Failed to map movies")
                XCTAssertEqual(1, value.page, "Failed to map paginated response")
                XCTAssertEqual(4951, value.totalResults, "Failed to map paginated response")
                XCTAssertEqual(248, value.totalPages, "Failed to map paginated response")
                if let movie = value.results?.first {
                    let date = DateFormatter.date(from: "2016-08-26",
                                                  format: Constants.DateFormats.default)!
                    XCTAssertEqual(date, movie.releaseDate, "Failed to map movies")
                    XCTAssertEqual(372058, movie.id, "Failed to map movies")
                    XCTAssertEqual("Your Name.", movie.title, "Failed to map movies")
                    XCTAssertNotNil(movie.posterURL, "Failed to map movies")
                    XCTAssertNotNil(movie.backdropPath, "Failed to map movies")
                } else {
                    XCTAssert(false, "Failed to map movies")
                }
            case .failure(let error):
                XCTAssertNil(error, "An error occured: \(error)")
            }
            
            // Fullfill the expectation
            e.fulfill()
        }
        
        waitForExpectations(timeout: 60.0) { (error: Error?) in
            print("\(error)")
        }
    }
    
}
