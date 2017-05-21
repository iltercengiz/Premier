//
//  SearchViewController.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/05/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import UIKit

final class SearchViewController: MovieListViewController, StoryboardLoadable, Instantiatable {
    
    static var defaultStoryboardName: String = Constants.StoryboardName.search
    
    fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var lastSearchesTableView: UITableView!
    var lastSearchesDataSource: LastSearchesDataSource!
    var lastSearchesDelegate: LastSearchesDelegate!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindLastSearches()
    }
    
}

private extension SearchViewController {
    
    func setup() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search movies" // FIXME: Localize
        navigationItem.titleView = searchBar
        self.searchBar = searchBar
        
        lastSearchesTableView.isHidden = true
    }
    
    func bindLastSearches() {
        lastSearchesTableView.dataSource = lastSearchesDataSource
        lastSearchesTableView.delegate = lastSearchesDelegate
        lastSearchesDelegate.selectionHandler = {
            [weak self] query in
            if let model = self?.model as? SearchViewModel {
                model.currentQuery = query
            }
            self?.searchBar.text = query
            self?.searchBar.resignFirstResponder()
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        defer {
            lastSearchesTableView.reloadData()
            lastSearchesTableView.isHidden = false
            searchBar.setShowsCancelButton(true, animated: true)
        }
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        defer {
            lastSearchesTableView.isHidden = true
            searchBar.setShowsCancelButton(false, animated: true)
        }
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        // print("\(searchBar.text)")
        guard let model = self.model as? SearchViewModel else { return }
        model.currentQuery = searchBar.text
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text?.isEmpty == true {
            (model as? SearchViewModel)?.clearMovies()
        }
    }
    
}
