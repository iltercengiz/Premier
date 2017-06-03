//
//  MovieDetailViewController.swift
//  Premier
//
//  Created by Ilter Cengiz on 25/04/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController, StoryboardLoadable, Instantiatable {
    
    static var defaultStoryboardName: String = Constants.StoryboardName.movieDetail
    
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var overviewTextView: UITextView!
    
    fileprivate var model: MovieDetailViewModel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Initializer
    
    static func instantiate(model: MovieDetailViewModel) -> Self {
        let viewController = loadFromStoryboard()
        viewController.model = model
        return viewController
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update scroll indicator insets
        var scrollIndicatorInsets = scrollView.scrollIndicatorInsets
        scrollIndicatorInsets.top = topLayoutGuide.length
        scrollView.scrollIndicatorInsets = scrollIndicatorInsets
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}

private extension MovieDetailViewController {
    
    func updateData() {
        imageView.kf.setImage(with: model.state.movie.posterURL,
                              placeholder: nil,
                              options: [.transition(.fade(Constants.defaultAnimationDuration))],
                              progressBlock: nil,
                              completionHandler: nil)
        titleLabel.text = model.state.movie.title
        overviewTextView.text = model.state.movie.overview
    }
    
}
