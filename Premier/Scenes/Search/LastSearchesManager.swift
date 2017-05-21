//
//  LastSearchesManager.swift
//  Premier
//
//  Created by Ilter Cengiz on 21/05/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import Foundation

class LastSearchesManager {
    
    private enum Const {
        static let numberOfLastSearchesToKeep: Int = 10
    }
    
    /**
     File path to the file that last searches will be persisted.
     */
    private var filePath: String = {
        let fileManager = FileManager.default
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            fatalError("Caches directory not available.")
        }
        let fileURL = cachesDirectory.appendingPathComponent("last_searches")
        return fileURL.path
    }()
    
    private(set) var lastSearches: [String]
    
    init() {
        if let lastSearches = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [String] {
            self.lastSearches = lastSearches
        } else {
            self.lastSearches = [] // Assign an empty array as we don't have any last search yet.
        }
    }
    
    deinit {
        // Write the updated list to file.
        NSKeyedArchiver.archiveRootObject(lastSearches, toFile: filePath)
    }
    
    func addSearchQuery(_ query: String) {
        // Insert the new query to top
        lastSearches.insert(query, at: 0)
        // Remove the oldest search if we exceed the cap
        if lastSearches.count > Const.numberOfLastSearchesToKeep {
            lastSearches.removeLast()
        }
    }
    
    func clearLastSearches() {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: filePath)
        } catch {
            // File not available.
        }
    }
    
}
