//
//  MovieDetailsViewModel.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 17/11/21.
//

import Foundation
import Combine

class MovieDetailsViewModel {
    
    private var cancelable: Set<AnyCancellable> = Set<AnyCancellable>()
    private var movieDetailsPublisher = CurrentValueSubject<MovieDetailsCellViewModel, Never>(MovieDetailsCellViewModel(movieID: 0, title: "", releaseDate: "", mostPopular: .average, backdropImageUrl: "", posterImageUrl: "", description: "", vote_average: 0, vote_count: 0, original_language: ""))
    
    init(movie: MovieDetailsModel) {
        self.movieDetailsPublisher.value = MovieDetailsCellViewModel(movieID: movie.movieID, title: movie.title, releaseDate: movie.releaseDate, mostPopular: movie.mostPopular, backdropImageUrl: movie.backdropImageUrl, posterImageUrl: movie.posterImageUrl, description: movie.description, vote_average: movie.vote_average, vote_count: movie.vote_count, original_language: movie.original_language)
    }
    
    func loadDetails(completion: @escaping (_ model: MovieDetailsCellViewModel) -> ()){
        
        self.movieDetailsPublisher.receive(on: DispatchQueue.main)
            .sink { (item) in
                completion(item)
            }.store(in: &cancelable)
        
    }
    
    deinit {
        print("MovieDetailsViewModel  deinit")
        self.cancelable.removeAll()
    }
}
