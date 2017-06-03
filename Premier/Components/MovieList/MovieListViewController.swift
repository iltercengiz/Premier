//
//  MovieListViewController.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/05/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

/**
 * Base view controller for simply listing movies.
 * Just provide a view-model to use as a source and present/embed/push this view controller.
 * It's safe to subclass this class to provide further functionality.
 */
class MovieListViewController: UIViewController {
    
    fileprivate enum Const {
        static let loadingCellHeight: CGFloat = 80.0
    }
    
    enum Route {
        case movie(Movie)
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var loadingIndicatorView: UIView?
    fileprivate weak var refreshControl: UIRefreshControl?
    
    // MARK: - Properties
    
    /**
     * Size calculation is handled manually to prevent jumps while scrolling and
     * if a pagination occurs.
     */
    fileprivate var cache = [IndexPath: CGFloat]()
    fileprivate let prototypeCell = MovieListTableViewCell.instantiate()
    var model: MovieListViewModel!
    var router: MovieListRouter?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setup()
        registerCells()
        reloadMovies()
    }
    
    // MARK: - Actions
    
    /// Used to set as action for refresh control
    func reloadMovies() {
        model.reloadMovies()
    }
    
    // MARK: Handlers
    
    func handleStateChange(change: MovieListState.Change) {
        switch change {
        case .moviesChanged(let collectionChange):
            switch collectionChange {
            case .reload:
                // Clear empty size cache
                cache.removeAll()
                // Reload table view by applying collection change
                tableView.applyCollectionChange(collectionChange,
                                                toSection: PaginatedListSection.content.rawValue,
                                                withAnimation: .fade)
                if model.state.movies.isEmpty {
                    // TODO: Present empty state
                } else {
                    // TODO: Dismiss empty state
                }
                // Stop refresh control
                refreshControl?.endRefreshing()
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
            if let loadingIndicatorView = self.loadingIndicatorView {
                if loadingIndicatorView.isHidden == false {
                    loadingIndicatorView.isHidden = activityTracker.isActive == false
                }
            }
        default:
            break
        }
    }
    
    func handleError(error: MovieListError) {
        // TODO: Error handling
    }
    
}

// MARK: - UI

private extension MovieListViewController {
    
    func bindViewModel() {
        model.stateChangeHandler = handleStateChange
        model.errorHandler = handleError
    }
    
    func setup() {
        loadingIndicatorView?.isHidden = true
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadMovies), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        self.refreshControl = refreshControl
    }
    
    func registerCells() {
        tableView.register(MovieListTableViewCell.defaultNib,
                           forCellReuseIdentifier: MovieListTableViewCell.defaultReuseIdentifier)
        tableView.register(LoadingTableViewCell.defaultNib,
                           forCellReuseIdentifier: LoadingTableViewCell.defaultReuseIdentifier)
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

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = PaginatedListSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            return tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.defaultReuseIdentifier,
                                                 for: indexPath) as! MovieListTableViewCell
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

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.route(
            to: .movie(model.state.movies[indexPath.row]),
            from: self
        )
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = PaginatedListSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        if section == .content {
            // Feed data into cell just before the cell appears
            if let movieCell = cell as? MovieListTableViewCell {
                let movie = model.state.movies[indexPath.row]
                movieCell.configure(with: movie)
            }
            if model.state.hasNextPage,
                indexPath.row == model.state.movies.count - PaginatedListSection.paginationOffset {
                model.loadMoreMovies()
            }
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
