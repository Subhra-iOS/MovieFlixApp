//
//  ViewController+Search.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 16/11/21.
//

import Foundation
import UIKit

extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        self.searchView.serach(movieInfo: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchView.serach(movieInfo: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        self.searchView.text = ""
        self.searchView.serach(movieInfo: "")
        self.searchView.resignFirstResponder()
    }
}

extension ViewController: SearchResultProtocol{
    func search(_ result: [SearchMovieModel], isSearchOn: Bool) {
        
        guard isSearchOn else {
            if let movies = self.tempSearchArray, movies.count > 0{ self.update(list: movies) }
            return
        }
        
        if result.count > 0, let movies = self.movieList, movies.count > 0{
            let allMovieIds : [Int] = result.map { (model) -> Int in
                return model.id
            }
            let _cellViewModels: [MovieListCellViewModel] = movies.filter({allMovieIds.contains($0.movieId)})
            
            self.update(list: _cellViewModels)
        }else{
            self.update(list: [])
        }
    }
    
}
