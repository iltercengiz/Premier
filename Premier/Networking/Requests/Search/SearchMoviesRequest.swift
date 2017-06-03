//
//  SearchMoviesRequest.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/05/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import Foundation

struct SearchMoviesRequest: Request {
    
    var method: HTTPMethod = .get
    var path: String = "/search/movie"
    var parameters: [String : Any] {
        return [
            "query": query,
            "page": page
        ]
    }
    
    private let query: String
    private let page: Int
    
    init(query: String, page: Int) {
        self.query = query
        self.page = page
    }
    
}
