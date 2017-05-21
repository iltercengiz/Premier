//
//  LastSearchesTests.swift
//  Premier
//
//  Created by Ilter Cengiz on 21/05/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import XCTest
@testable import Premier

class LastSearchesTests: XCTestCase {
    
    let lastSearchesManager = LastSearchesManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        lastSearchesManager.clearLastSearches()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddQuery() {
        lastSearchesManager.addSearchQuery("Test query 1")
        lastSearchesManager.addSearchQuery("Test query 2")
        lastSearchesManager.addSearchQuery("Test query 3")
        XCTAssertEqual(lastSearchesManager.lastSearches.count, 3)
    }
    
    func testPersistency() {
        // Last searches already cleared.
        var manager: LastSearchesManager? = LastSearchesManager()
        manager?.addSearchQuery("Test query 1")
        manager?.addSearchQuery("Test query 2")
        manager?.addSearchQuery("Test query 3")
        // Kill manager object to trigger save operation
        manager = nil
        // Create another instance to check
        manager = LastSearchesManager()
        XCTAssertEqual(manager?.lastSearches.count, 3)
        XCTAssertEqual(manager?.lastSearches.first, "Test query 3")
        XCTAssertEqual(manager?.lastSearches.last, "Test query 1")
    }
    
    func testOverflow() {
        lastSearchesManager.addSearchQuery("Test query 1")
        lastSearchesManager.addSearchQuery("Test query 2")
        lastSearchesManager.addSearchQuery("Test query 3")
        lastSearchesManager.addSearchQuery("Test query 4")
        lastSearchesManager.addSearchQuery("Test query 5")
        lastSearchesManager.addSearchQuery("Test query 6")
        lastSearchesManager.addSearchQuery("Test query 7")
        lastSearchesManager.addSearchQuery("Test query 8")
        lastSearchesManager.addSearchQuery("Test query 9")
        lastSearchesManager.addSearchQuery("Test query 10")
        lastSearchesManager.addSearchQuery("Test query 11")
        XCTAssertEqual(lastSearchesManager.lastSearches.first, "Test query 11")
        XCTAssertEqual(lastSearchesManager.lastSearches.last, "Test query 2")
    }
    
    func testSearchAgain() {
        lastSearchesManager.addSearchQuery("Test query 1") // 1
        lastSearchesManager.addSearchQuery("Test query 2") // 2, 1
        lastSearchesManager.addSearchQuery("Test query 3") // 3, 2, 1
        lastSearchesManager.addSearchQuery("Test query 1") // 1, 3, 2
        XCTAssertEqual(lastSearchesManager.lastSearches.count, 3)
        XCTAssertEqual(lastSearchesManager.lastSearches.first, "Test query 1")
        XCTAssertEqual(lastSearchesManager.lastSearches.last, "Test query 2")
    }
    
}
