//
//  TopRatedMoviesRequest.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import Foundation

struct TopRatedMoviesRequest: Request {
    
    var method: HTTPMethod = .get
    var path: String = "/movie/top_rated"
    var parameters: [String : Any] {
        return ["page": page]
    }
    
    private let page: Int
    
    init(page: Int) {
        self.page = page
    }
}
