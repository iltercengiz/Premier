//
//  Response.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import ObjectMapper

struct Response<Value: Mappable> {
    
    var request: URLRequest?
    var response: HTTPURLResponse?
    var data: Data?
    var result: Result<Value>
    
}
