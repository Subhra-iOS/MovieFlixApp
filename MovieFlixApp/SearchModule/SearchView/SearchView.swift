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
    
    private var movies: [SearchMovieModel]?
    private var searchDelegate: SearchResultProtocol?

    func set(list: [SearchMovieModel], searchDelegate: SearchResultProtocol?){
        self.movies = list
        self.searchDelegate = searchDelegate
    }
    
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
            
            return foundSearch(movieInfo, model)
        }
        if result.count > 0 {
            self.searchDelegate?.search(result, isSearchOn: true)
        }else{
            self.searchDelegate?.search([], isSearchOn: true)
        }
    }
    
    private func foundSearch(_ txt: String,_ model: SearchMovieModel) -> Bool{
        let capText: String = txt.capitalized
        let isContain: Bool = model.title.capitalized.contains(capText) || model.description.capitalized.contains(capText)
        return isContain
    }
}

