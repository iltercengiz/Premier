//
//  SearchViewModel.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/05/2017.
//  Copyright © 2017 Deliveroo. All rights reserved.
//

import Foundation

class SearchViewModel: MovieListViewModel {
    
    fileprivate(set) var state = MovieListState()
    var currentQuery: String? {
        didSet {
            reloadMovies()
        }
    }
    
    var stateChangeHandler: ((MovieListState.Change) -> Void)?
    var errorHandler: ((MovieListError) -> Void)?
    
    func reloadMovies() {
        guard let query = currentQuery else { return }
        fetchMovies(with: query, page: 1) {
            [weak self] (movies: [Movie]) in
            guard let strongSelf = self else { return }
            strongSelf.emit(change: strongSelf.state.reload(movies: movies))
        }
    }
    
    func loadMoreMovies() {
        guard let query = currentQuery else { return }
        guard state.hasNextPage else { return }
        fetchMovies(with: query, page: state.currentPage + 1) {
            [weak self] (movies: [Movie]) in
            guard let strongSelf = self else { return }
            strongSelf.emit(change: strongSelf.state.insert(movies: movies))
        }
    }
    
}

private extension SearchViewModel {
    
    func fetchMovies(with query: String, page: Int, handler: @escaping ([Movie]) -> Void) {
        emit(change: state.addActivity())
        let request = SearchMoviesRequest(query: query, page: page)
        MovieDatabaseClient.shared.execute(request) {
            [weak self] (response: Response<PaginatedResponse<Movie>>) in
            guard let strongSelf = self else { return }
            switch response.result {
            case .success(let value):
                guard let movies = value.results,
                    let currentPage = value.page,
                    let totalPages = value.totalPages
                    else {
                        strongSelf.emit(error: .mappingFailed)
                        return
                }
                strongSelf.state.update(currentPage: currentPage,
                                        totalPages: totalPages)
                handler(movies)
            case .failure(let error):
                strongSelf.emit(error: .connectionError(error))
            }
            strongSelf.emit(change: strongSelf.state.removeActivity())
        }
    }
    
}
