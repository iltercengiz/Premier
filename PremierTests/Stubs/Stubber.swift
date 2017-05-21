//
//  Stubber.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import Foundation
import OHHTTPStubs

private let APIURL = URL(string: "https://api.themoviedb.org/3")!

class Stubber {
    
    static func stubRequest(for path: String, JSONName: String, queryParameters: [String: String] = [:]) {
        stub(condition: isHost(APIURL.host!) && isMethodGET() && pathStartsWith(path) && containsQueryParams(queryParameters)) {
            (request: URLRequest) -> OHHTTPStubsResponse in
            let JSONPath = OHPathForFile(JSONName, Stubber.self)!
            return fixture(filePath: JSONPath, headers: nil)
        }
    }
    
}

// MARK: - Movies

extension Stubber {
    
    static func stubTopRatedPage1() {
        stubRequest(for: "/3/movie/top_rated",
                    JSONName: "top_rated_page_1.json",
                    queryParameters: ["page": "1"])
    }
    
    static func stubTopRatedPage2() {
        stubRequest(for: "/3/movie/top_rated",
                    JSONName: "top_rated_page_2.json",
                    queryParameters: ["page": "2"])
    }
    
    static func stubSearch() {
        stubRequest(for: "/3/search/movie",
                    JSONName: "search.json")
    }
    
}
