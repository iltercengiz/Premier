//
//  MovieListViewModel.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/05/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import Foundation

enum MovieListError {
    case connectionError(Error)
    case mappingFailed
    case reloadFailed
}

protocol MovieListViewModel {
    
    var state: MovieListState { get }
    
    var stateChangeHandler: ((MovieListState.Change) -> Void)? { get set }
    var errorHandler: ((MovieListError) -> Void)? { get set }
    
    func reloadMovies()
    func loadMoreMovies()
    
}

extension MovieListViewModel {
    
    func emit(change: MovieListState.Change) {
        stateChangeHandler?(change)
    }
    
    func emit(error: MovieListError) {
        errorHandler?(error)
    }
    
}
