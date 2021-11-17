//
//  MovieDetailsModel.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 17/11/21.
//

import Foundation

struct MovieDetailsModel {
    let movieID: Int
    let title: String
    let releaseDate: String
    let mostPopular: MovieType
    let backdropImageUrl: String
    let posterImageUrl: String
    let description: String
    let vote_average: Double
    let vote_count: Double
    let original_language: String
}

struct MovieDetailsCellViewModel: ImageDownloaderProtocol {
    let movieID: Int
    let title: String
    let releaseDate: String
    let mostPopular: MovieType
    let backdropImageUrl: String
    let posterImageUrl: String
    let description: String
    let vote_average: Double
    let vote_count: Double
    let original_language: String
}
