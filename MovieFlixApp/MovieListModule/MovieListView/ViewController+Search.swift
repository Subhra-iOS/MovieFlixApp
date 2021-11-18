//
//  ViewController+Search.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 16/11/21.
//

import Foundation
import UIKit

extension ViewController{
    
    func generateSearchMoviesModelswith(list: [MovieListCellViewModel]){
        let searchMovies: [SearchMovieModel] = list.map { (cellViewModel) -> SearchMovieModel in
            return SearchMovieModel(id: cellViewModel.movieId, title: cellViewModel.title, description: cellViewModel.overview)
        }
        
        self.searchView.set(list: searchMovies, searchDelegate: self)
        self.searchView.delegate = self
    }
}

//MARK:-----UISearchBar Delegate functions---------//
extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        self.searchView.serach(movieInfo: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchView.serach(movieInfo: searchBar.text ?? "")
        self.searchView.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        self.searchView.text = ""
        self.searchView.serach(movieInfo: "")
        self.searchView.resignFirstResponder()
    }
}

//MARK:------Search result protocol---------//
extension ViewController: SearchResultProtocol{
    func search(_ result: [SearchMovieModel], isSearchOn: Bool) {
        
        guard isSearchOn else {
            if let movies = self.tempSearchArray, movies.count > 0{ self.updateSearch(list: movies) }
            return
        }
        
        if result.count > 0, let movies = self.movieList, movies.count > 0{
            let allMovieIds : [Int] = result.map { (model) -> Int in
                return model.id
            }
            let _cellViewModels: [MovieListCellViewModel] = movies.filter({allMovieIds.contains($0.movieId)})
            
            self.updateSearch(list: _cellViewModels)
        }else{
            self.updateSearch(list: [])
        }
    }
    
}
