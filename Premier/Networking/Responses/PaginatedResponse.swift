//
//  PaginatedResponse.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import Foundation
import ObjectMapper

struct PaginatedResponse<T>: Mappable where T: Mappable {
    
    private(set) var page: Int?
    private(set) var results: [T]?
    private(set) var totalResults: Int?
    private(set) var totalPages: Int?
    
    // MARK: - Mappable
    
    init?(map: Map) {
        // Check map.JSON for any invalid value
    }
    
    mutating func mapping(map: Map) {
        page <- map["page"]
        results <- map["results"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
    }
    
}
