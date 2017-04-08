//
//  TopMoviesTests.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 20/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import XCTest
@testable import PremierSwift

class TopMoviesTests: XCTestCase {
    
    let model = TopMoviesViewModel()
    
    override func setUp() {
        super.setUp()
        Stubber.stubTopRatedPage1()
        Stubber.stubTopRatedPage2()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMoviesFetching() {
        let e1 = expectation(description: "top movies reload")
        
        model.stateChangeHandler = { [unowned model] change in
            switch change {
            case .moviesChanged(let collectionChange):
                XCTAssert(collectionChange == CollectionChange.reload)
                XCTAssert(model.state.movies.count == 20)
                e1.fulfill()
            default:
                break
            }
        }
        model.reloadMovies()
        
        waitForExpectations(timeout: 10.0) { (error: Error?) in
            print("\(error)")
        }
        
        let e2 = expectation(description: "top movies load more")
        
        model.stateChangeHandler = { [unowned model] change in
            switch change {
            case .moviesChanged(let collectionChange):
                XCTAssert(collectionChange == CollectionChange.insertion(IndexSet(integersIn: 20..<40)))
                XCTAssert(model.state.movies.count == 40)
                e2.fulfill()
            default:
                break
            }
        }
        model.loadMoreMovies()
        
        waitForExpectations(timeout: 10.0) { (error: Error?) in
            print("\(error)")
        }
    }
    
}
