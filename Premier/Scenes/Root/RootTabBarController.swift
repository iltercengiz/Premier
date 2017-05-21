//
//  RootTabBarController.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/05/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import UIKit

final class RootTabBarController: UITabBarController, StoryboardLoadable, Instantiatable {
    
    static var defaultStoryboardName: String = Constants.StoryboardName.root
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

private extension RootTabBarController {
    
    func setup() {
        let topMoviesViewController = TopMoviesViewController.instantiate()
        topMoviesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        topMoviesViewController.model = TopMoviesViewModel()
        topMoviesViewController.router = TopMoviesRouter()
        let topMoviesNavigationController = UINavigationController(rootViewController: topMoviesViewController)
        
        let searchViewController = SearchViewController.instantiate()
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        let lastSearchesManager = LastSearchesManager()
        searchViewController.model = SearchViewModel(lastSearchesManager: lastSearchesManager)
        searchViewController.lastSearchesDataSource = LastSearchesDataSource(lastSearchesManager: lastSearchesManager)
        // TODO: router
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        
        viewControllers = [topMoviesNavigationController, searchNavigationController]
    }
    
}
