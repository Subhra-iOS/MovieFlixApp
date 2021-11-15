//
//  MovieListViewModel.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import Foundation
import Combine

struct MovieListCellViewModel {
    let movieId: Double
    let mostPopular: Bool
    let backdropImageUrl: String
    let posterImageUrl: String
    let title: String
    let overview: String
    let releaseDate: String
    let vote_average: Double
    let vote_count: Double
    let original_language: String
}

class MovieListViewModel {
    private let serviceManager: ListServiceManager
    
    var cancelable: Set<AnyCancellable> = Set<AnyCancellable>()
    var moviePublisher = CurrentValueSubject<[MovieListCellViewModel]?, Never>([MovieListCellViewModel(movieId: 0, mostPopular: false, backdropImageUrl: "", posterImageUrl: "", title: "", overview: "", releaseDate: "", vote_average: 0.0, vote_count: 0.0, original_language: "")])
    
    init(serviceManager: ListServiceManager) {
        self.serviceManager = serviceManager
        self.fetchMovieList()
    }
    
    private func fetchMovieList(){
        self.serviceManager.fetchList { (result) in
            switch result{
                case .success(let movies):
                    self.moviePublisher.value = movies.compactMap({ (item) -> MovieListCellViewModel? in
                        return  MovieListCellViewModel(movieId:item.id, mostPopular: item.mostPopular, backdropImageUrl: item.backdropImageUrl, posterImageUrl: item.posterImageUrl, title: item.original_title, overview: item.overview, releaseDate: item.release_date, vote_average: item.vote_average, vote_count: item.vote_count, original_language: item.original_title)
                    })
                case .failure(_): self.moviePublisher.value = nil
            }
        }
    }
    
    deinit {
        print("MovieListViewModel  deinit")
        self.cancelable.removeAll()
    }
}
