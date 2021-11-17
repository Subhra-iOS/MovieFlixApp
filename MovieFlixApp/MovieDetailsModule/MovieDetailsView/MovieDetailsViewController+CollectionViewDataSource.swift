//
//  MovieDetailsViewController+CollectionViewDataSource.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 17/11/21.
//

import Foundation
import UIKit

extension MovieDetailsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let _: MovieDetailsModel = self.movieDesModel{
            return 1
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if let movie: MovieDetailsModel = self.movieDesModel,
           let cell : DetailsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: detailsCollectionViewCell, for: indexPath) as? DetailsCollectionViewCell{
            
            cell.cellViewModel = MovieDetailsCellViewModel(movieID: movie.movieID, title: movie.title, releaseDate: movie.releaseDate, mostPopular: movie.mostPopular, backdropImageUrl: movie.backdropImageUrl, posterImageUrl: movie.posterImageUrl, description: movie.description, vote_average: movie.vote_average, vote_count: movie.vote_count, original_language: movie.original_language)
            
            cell.reloadImage()
            
            return cell
            
        }
        return UICollectionViewCell()
    }
    
}
