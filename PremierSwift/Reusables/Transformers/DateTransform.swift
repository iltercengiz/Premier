//
//  DateTransform.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import ObjectMapper

class DateTransform: TransformType {
    typealias Object = Date
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            return DateFormatter.date(from: dateString,
                                      format: Constants.DateFormats.default)
        }
        return nil
    }
    
    func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return DateFormatter.string(from: date,
                                        format: Constants.DateFormats.default)
        }
        return nil
    }
}
