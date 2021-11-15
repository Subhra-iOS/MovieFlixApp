//
//  MovieListModel.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import Foundation

struct MovieList: Decodable {
    let total_pages: Double
    let total_results: Double
    let page: Double
    let dates: Dates
    let results: [MovieElement]?
}

struct Dates: Decodable {
    let maximum: String
    let minimum: String
}

struct MovieElement: Decodable {
    let adult: Bool
    let backdrop_path: String
    let id: Double
    let original_language: String
    let original_title : String
    let overview : String
    let popularity : Double
    let poster_path : String
    let release_date : String
    let title : String
    let video : Bool
    let vote_average : Double
    let vote_count : Double
    
    var mostPopular: Bool{
        return vote_average > 7
    }
    var backdropImageUrl: String{
        return API.Image.backdrop_baseUrl + self.backdrop_path
    }
    
    var posterImageUrl: String{
        return API.Image.poster_baseUrl + self.poster_path
    }
}
