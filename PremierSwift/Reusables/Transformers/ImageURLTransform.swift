//
//  ImageURLTransform.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import ObjectMapper

private let ImagesBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")!

class ImageURLTransform: TransformType {
    typealias Object = URL
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> URL? {
        if let path = value as? String {
            return ImagesBaseURL.appendingPathComponent(path)
        }
        return nil
    }
    
    func transformToJSON(_ value: URL?) -> String? {
        return value?.absoluteString
    }
}
