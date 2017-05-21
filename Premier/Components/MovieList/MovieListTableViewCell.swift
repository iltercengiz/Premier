//
//  MovieListTableViewCell.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/05/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import UIKit
import Kingfisher

final class MovieListTableViewCell: UITableViewCell, NibLoadable, Instantiatable {
    
    @IBOutlet fileprivate weak var posterImageView: UIImageView! {
        didSet {
            if let imageView = posterImageView {
                imageView.kf.indicatorType = .activity
            }
        }
    }
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var releaseDateLabel: UILabel!
    @IBOutlet fileprivate weak var overviewLabel: UILabel!
    
    // MARK: - View life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.ps_styleText(.title1)
        overviewLabel.ps_styleText(.body)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil // Alternatively we can set a placeholder image
        titleLabel.text = nil
        overviewLabel.text = nil
    }
    
    // MARK: Configuration
    
    func configure(with movie: Movie) {
        posterImageView.kf.setImage(with: movie.posterURL,
                                    placeholder: nil,
                                    options: [.transition(.fade(Constants.defaultAnimationDuration))],
                                    progressBlock: nil,
                                    completionHandler: nil)
        titleLabel.text = movie.title
        if let date = movie.releaseDate {
            releaseDateLabel.text = DateFormatter.string(from: date, format: "yyyy")
        }
        overviewLabel.text = movie.overview
    }
    
}
