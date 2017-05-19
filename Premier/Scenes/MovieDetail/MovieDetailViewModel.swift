//
//  MovieDetailViewModel.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 25/04/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import Foundation

struct MovieDetailState {
    private(set) var movie: Movie
}

class MovieDetailViewModel {
    
    let state: MovieDetailState
    
    init(movie: Movie) {
        state = MovieDetailState(movie: movie)
    }
    
}
