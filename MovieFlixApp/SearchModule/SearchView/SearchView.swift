//
//  SearchView.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import Foundation
import UIKit

struct SearchMovieModel {
    let id: Int
    let title: String
    let description: String
}

protocol SearchResultProtocol {
    func search(_ result: [SearchMovieModel], isSearchOn: Bool)
}

class SearchView: UISearchBar {
    
    var movies: [SearchMovieModel]?
    var searchDelegate: SearchResultProtocol?

    
    func serach(movieInfo: String){
        
        guard let list = self.movies else {
            self.searchDelegate?.search([], isSearchOn: false)
            return
        }
        
        guard movieInfo.count > 0 else {
            self.searchDelegate?.search([], isSearchOn: false)
            return
        }
        
        let result = list.filter { (model) -> Bool in
            return model.title.contains(movieInfo) || model.description.contains(movieInfo)
        }
        if result.count > 0 {
            self.searchDelegate?.search(result, isSearchOn: true)
        }else{
            self.searchDelegate?.search([], isSearchOn: true)
        }
    }
}

