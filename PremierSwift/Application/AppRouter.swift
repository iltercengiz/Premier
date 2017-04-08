//
//  AppRouter.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import UIKit

class AppRouter {
    
    private weak var appWindow: UIWindow?
    
    init(window: UIWindow) {
        appWindow = window
    }
    
    // MARK: - Presentations
    
    func presentMainFlow() {
        let topMoviesViewController = TopMoviesViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: topMoviesViewController)
        appWindow?.rootViewController = navigationController
        appWindow?.makeKeyAndVisible()
    }
    
}
