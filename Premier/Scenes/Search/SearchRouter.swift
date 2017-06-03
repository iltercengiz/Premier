//
//  SearchRouter.swift
//  Premier
//
//  Created by Ilter Cengiz on 21/05/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

struct SearchRouter: MovieListRouter {
    
    func route(to route: MovieListViewController.Route, from source: MovieListViewController) {
        switch route {
        case .movie(let movie):
            routeToMovieDetail(with: movie, from: source)
        }
    }
    
}

private extension SearchRouter {
    
    func routeToMovieDetail(with movie: Movie, from source: UIViewController) {
        let model = MovieDetailViewModel(movie: movie)
        let viewController = MovieDetailViewController.instantiate(model: model)
        source.present(viewController, animated: true, completion: nil)
    }
    
}
