//
//  TopMoviesViewModel.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import Foundation

class TopMoviesViewModel: MovieListViewModel {
    
    fileprivate(set) var state = MovieListState()
    
    var stateChangeHandler: ((MovieListState.Change) -> Void)?
    var errorHandler: ((MovieListError) -> Void)?
    
    func reloadMovies() {
        Stubber.stubTopRatedPage1()
        fetchMovies(at: 1) {
            [weak self] (movies: [Movie]) in
            guard let strongSelf = self else { return }
            strongSelf.emit(change: strongSelf.state.reload(movies: movies))
        }
    }
    
    func loadMoreMovies() {
        Stubber.stubTopRatedPage2()
        guard state.hasNextPage else { return }
        fetchMovies(at: state.currentPage + 1) {
            [weak self] (movies: [Movie]) in
            guard let strongSelf = self else { return }
            strongSelf.emit(change: strongSelf.state.insert(movies: movies))
        }
    }
    
}

private extension TopMoviesViewModel {
    
    func fetchMovies(at page: Int, handler: @escaping ([Movie]) -> Void) {
        emit(change: state.addActivity())
        let request = TopRatedMoviesRequest(page: page)
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
