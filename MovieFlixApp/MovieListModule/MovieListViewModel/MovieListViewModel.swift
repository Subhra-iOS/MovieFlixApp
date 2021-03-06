//
//  MovieListViewModel.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import Foundation
import Combine

struct MovieListCellViewModel: ImageDownloaderProtocol {
    let movieId: Int
    let mostPopular: MovieType
    let backdropImageUrl: String
    let posterImageUrl: String
    let title: String
    let overview: String
    let releaseDate: String
    let vote_average: Double
    let vote_count: Double
    let original_language: String
    var isDeleteHidden: Bool = true
    
}

class MovieListViewModel {
    private let serviceManager: ListServiceManager
    
    private var cancelable: Set<AnyCancellable> = Set<AnyCancellable>()
    private var moviePublisher = CurrentValueSubject<[MovieListCellViewModel]?, Never>([MovieListCellViewModel(movieId: -1, mostPopular: .average, backdropImageUrl: "", posterImageUrl: "", title: "", overview: "", releaseDate: "", vote_average: 0.0, vote_count: 0.0, original_language: "", isDeleteHidden: true)])
    
    init(serviceManager: ListServiceManager) {
        self.serviceManager = serviceManager
        self.fetchMovieList()
    }
    
    private func fetchMovieList(){
        self.serviceManager.fetchList { (result) in
            switch result{
                case .success(let movies):
                    self.moviePublisher.value = movies.compactMap({ (item) -> MovieListCellViewModel? in
                        return  MovieListCellViewModel(movieId:item.id, mostPopular: item.mostPopular, backdropImageUrl: item.backdropImageUrl, posterImageUrl: item.posterImageUrl, title: item.original_title, overview: item.overview, releaseDate: item.release_date, vote_average: item.vote_average, vote_count: item.vote_count, original_language: item.original_title, isDeleteHidden: true)
                    })
                case .failure(_): self.moviePublisher.value = nil
            }
        }
    }
    
    func updateColletionList(closure: @escaping (_ models: [MovieListCellViewModel]?) ->()){
        
        self.moviePublisher.receive(on: DispatchQueue.main)
            .filter({ (models) -> Bool in
                guard let list = models else { return false }
                return list.filter({$0.movieId != 0}).count > 0
            })
            .sink(receiveValue: { (list) in
                print("\(String(describing: list))")
                closure(list)
            }).store(in: &cancelable)
    }
    
    deinit {
        print("MovieListViewModel  deinit")
        self.cancelable.removeAll()
    }
}
