//
//  Localization.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/05/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import Foundation

struct Localization {
    
    // MARK: - Tables
    
    static let common = Localization(tableName: "Common")
    static let topMovies = Localization(tableName: "TopMovies")
    static let search = Localization(tableName: "Search")
    
    // MARK: Localization
    
    fileprivate let tableName: String
    
    init(tableName: String) {
        self.tableName = tableName
    }
    
    func string(for key: String) -> String {
        let string = Bundle.main.localizedString(forKey: key, value: "[NO_LOCALIZATION]", table: tableName)
        return string
    }
    
    func string(withFormat format: String, _ arguments: CVarArg...) -> String {
        let formatString = string(for: format)
        return String(format: formatString, arguments: arguments)
    }
    
}
