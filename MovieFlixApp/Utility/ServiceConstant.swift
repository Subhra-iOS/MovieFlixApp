//
//  ServiceConstant.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import Foundation

enum API{
    
    enum Key{
        static let api_Key = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    }
    
    enum Service{
        static let movies_baseUrl = "https://api.themoviedb.org/3/movie/"
    }
    
    enum Image {
        static let backdrop_baseUrl = "https://image.tmdb.org/t/p/original"
        static let poster_baseUrl = "https://image.tmdb.org/t/p/w342"
    }
    
    enum URLKeys: String{
        case apiKey = "api_key"
    }
}

enum ServiceError: Error {
    case invalid
    case noData
}


