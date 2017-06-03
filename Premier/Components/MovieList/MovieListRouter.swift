//
//  MovieListRouter.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/05/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import Foundation

protocol MovieListRouter {
    
    func route(to route: MovieListViewController.Route, from source: MovieListViewController)
    
}
