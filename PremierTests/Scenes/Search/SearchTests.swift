//
//  SearchTests.swift
//  Premier
//
//  Created by Ilter Cengiz on 21/05/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import XCTest
@testable import Premier

class SearchTests: XCTestCase {
    
    let model = SearchViewModel()
    
    override func setUp() {
        super.setUp()
        Stubber.stubSearch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSearch() {
        let e = expectation(description: "search reload")
        
        model.stateChangeHandler = { [unowned model] change in
            switch change {
            case .moviesChanged(let collectionChange):
                XCTAssert(collectionChange == CollectionChange.reload)
                XCTAssert(model.state.movies.count == 20)
                e.fulfill()
            default:
                break
            }
        }
        model.currentQuery = "Godfather" // Also reloads movies
        
        waitForExpectations(timeout: 10.0) { (error: Error?) in
            print("\(error)")
        }
    }
    
}
