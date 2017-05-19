//
//  TopMoviesRouter.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 25/04/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import UIKit

struct TopMoviesRouter {
    
    func route(to route: TopMoviesViewController.Route, from source: UIViewController) {
        switch route {
        case .movieDetail(let movie):
            routeToMovieDetail(with: movie, from: source)
        }
    }
    
}

private extension TopMoviesRouter {
    
    func routeToMovieDetail(with movie: Movie, from source: UIViewController) {
        let model = MovieDetailViewModel(movie: movie)
        let viewController = MovieDetailViewController.instantiate(model: model)
        source.present(viewController, animated: true, completion: nil)
    }
    
}
