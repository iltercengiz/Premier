//
//  MovieListState.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/05/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import Foundation

struct MovieListState {
    fileprivate(set) var movies: [Movie] = []
    fileprivate(set) var loading: ActivityTracker = ActivityTracker()
    fileprivate(set) var currentPage: Int = 1
    fileprivate(set) var totalPages: Int = 1
    var hasNextPage: Bool {
        return currentPage != totalPages
    }
}

extension MovieListState {
    
    enum Change {
        case none
        case moviesChanged(CollectionChange)
        case loadingChanged(ActivityTracker)
    }
    
    mutating func reload(movies: [Movie]) -> Change {
        self.movies = movies
        return .moviesChanged(.reload)
    }
    
    mutating func insert(movies: [Movie]) -> Change {
        let index = self.movies.count
        self.movies.append(contentsOf: movies)
        let range = IndexSet(integersIn: index..<self.movies.count)
        return .moviesChanged(.insertion(range))
    }
    
    mutating func update(currentPage: Int, totalPages: Int) {
        self.currentPage = currentPage
        self.totalPages = totalPages
    }
    
    mutating func addActivity() -> Change {
        loading.addActivity()
        return .loadingChanged(loading)
    }
    
    mutating func removeActivity() -> Change {
        loading.removeActivity()
        return .loadingChanged(loading)
    }
    
}
