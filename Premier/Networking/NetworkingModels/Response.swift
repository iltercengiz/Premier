//
//  Response.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import ObjectMapper

struct Response<Value: Mappable> {
    
    var request: URLRequest?
    var response: HTTPURLResponse?
    var data: Data?
    var result: Result<Value>
    
}
