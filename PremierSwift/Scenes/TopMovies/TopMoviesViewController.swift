//
//  TopMoviesViewController.swift
//  PremierSwift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import UIKit

final class TopMoviesViewController: UIViewController, StoryboardLoadable, Instantiatable {
    
    static var defaultStoryboardName: String = Constants.StoryboardName.topMovies
    
    fileprivate enum Const {
        static let loadingCellHeight: CGFloat = 80.0
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var loadingIndicatorView: UIView!
    
    // MARK: - Properties
    
    fileprivate var cache = [IndexPath: CGFloat]()
    fileprivate let model = TopMoviesViewModel()
    fileprivate let prototypeCell = TopMoviesTableViewCell.instantiate()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setup()
        registerCells()
        model.reloadMovies()
    }
    
}

// MARK: - UI

private extension TopMoviesViewController {
    
    func bindViewModel() {
        model.stateChangeHandler = handleStateChange
        model.errorHandler = handleError
    }
    
    func setup() {
        // Do any UI setup here
    }
    
    func registerCells() {
        tableView.register(TopMoviesTableViewCell.defaultNib,
                           forCellReuseIdentifier: TopMoviesTableViewCell.defaultReuseIdentifier)
        tableView.register(LoadingTableViewCell.defaultNib,
                           forCellReuseIdentifier: LoadingTableViewCell.defaultReuseIdentifier)
    }
    
    // MARK: Handlers
    
    func handleStateChange(change: TopMoviesState.Change) {
        switch change {
        case .moviesChanged(let collectionChange):
            switch collectionChange {
            case .reload:
                tableView.applyCollectionChange(collectionChange,
                                                toSection: PaginatedListSection.content.rawValue,
                                                withAnimation: .fade)
                if model.state.movies.isEmpty {
                    // TODO: Present empty state
                } else {
                    // TODO: Dismiss empty state
                }
            default:
                tableView.beginUpdates()
                if !model.state.hasNextPage {
                    tableView.applyCollectionChange(CollectionChange.deletion(0),
                                                    toSection: PaginatedListSection.loading.rawValue,
                                                    withAnimation: .fade)
                }
                tableView.applyCollectionChange(collectionChange,
                                                toSection: PaginatedListSection.content.rawValue,
                                                withAnimation: .fade)
                tableView.endUpdates()
            }
        case .loadingChanged(let activityTracker):
            if loadingIndicatorView.isHidden == false {
                loadingIndicatorView.isHidden = activityTracker.isActive == false
            }
        default:
            break
        }
    }
    
    func handleError(error: TopMoviesError) {
        // TODO: Error handling
    }
    
    // MARK: Size calculations
    
    func height(at indexPath: IndexPath) -> CGFloat {
        guard let section = PaginatedListSection(rawValue: indexPath.section),
              section == .content else {
            fatalError("Invalid section to size!")
        }
        if let height = cache[indexPath] {
            return height
        } else {
            let movie = model.state.movies[indexPath.row]
            prototypeCell.configure(with: movie)
            var size = UILayoutFittingCompressedSize
            size.width = tableView.bounds.size.width
            let height = CGFloat(ceilf(Float(prototypeCell.systemLayoutSizeFitting(size,
                                                                                   withHorizontalFittingPriority: UILayoutPriorityRequired,
                                                                                   verticalFittingPriority: 251).height)))
            cache[indexPath] = height
            return height
        }
    }
    
}

// MARK: - UITableViewDataSource

extension TopMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = PaginatedListSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopMoviesTableViewCell.defaultReuseIdentifier,
                                                     for: indexPath) as! TopMoviesTableViewCell
            let movie = model.state.movies[indexPath.row]
            cell.configure(with: movie)
            return cell
        case .loading:
            return tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.defaultReuseIdentifier,
                                                 for: indexPath)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return PaginatedListSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = PaginatedListSection(rawValue: section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            return model.state.movies.count
        case .loading:
            return model.state.hasNextPage ? 1 : 0
        }
    }
    
}

// MARK: - UITableViewDelegate

extension TopMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = PaginatedListSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        if section == .content,
           model.state.hasNextPage,
           indexPath.row == model.state.movies.count - PaginatedListSection.paginationOffset {
            model.loadMoreMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = PaginatedListSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            return height(at: indexPath)
        case .loading:
            return Const.loadingCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = PaginatedListSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            return height(at: indexPath)
        case .loading:
            return Const.loadingCellHeight
        }
    }
    
}
