//
//  PaginatedListSection.swift
//  Premier
//
//  Created by Ilter Cengiz on 20/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import Foundation

enum PaginatedListSection: Int {
    case content
    case loading
    
    static let count = 2
    static let paginationOffset = 2
}
