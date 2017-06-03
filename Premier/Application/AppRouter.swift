//
//  AppRouter.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

class AppRouter {
    
    private weak var appWindow: UIWindow?
    
    init(window: UIWindow) {
        appWindow = window
    }
    
    // MARK: - Presentations
    
    func presentMainFlow() {
        let rootTabBarController = RootTabBarController.instantiate()
        appWindow?.rootViewController = rootTabBarController
        appWindow?.makeKeyAndVisible()
    }
    
}
