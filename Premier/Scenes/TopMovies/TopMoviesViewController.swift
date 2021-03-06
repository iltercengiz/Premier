//
//  TopMoviesViewController.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

final class TopMoviesViewController: MovieListViewController, StoryboardLoadable, Instantiatable {
    
    static var defaultStoryboardName: String = Constants.StoryboardName.topMovies
    
    @IBOutlet fileprivate weak var loadingLabel: UILabel!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

private extension TopMoviesViewController {
    
    func setup() {
        title = Localization.topMovies.string(for: "TOP_MOVIES")
        loadingLabel.text = Localization.common.string(for: "LOADING")
    }
    
}
