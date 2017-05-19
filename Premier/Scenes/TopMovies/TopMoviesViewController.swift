//
//  TopMoviesViewController.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import UIKit

final class TopMoviesViewController: MovieListViewController, StoryboardLoadable, Instantiatable {
    
    static var defaultStoryboardName: String = Constants.StoryboardName.topMovies
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

private extension TopMoviesViewController {
    
    func setup() {
        tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
    }
    
}
