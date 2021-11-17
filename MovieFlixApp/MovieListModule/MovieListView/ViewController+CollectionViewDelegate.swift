//
//  ViewController+CollectionViewDelegate.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 16/11/21.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDelegate{
    
    fileprivate func updateCollectionViewSelectionWith(_ collectionView: UICollectionView, _ indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if let itemList: [MovieListCellViewModel] = self.movieList, itemList.count > 0 {
            let model: MovieListCellViewModel = itemList[indexPath.item]
            print("\(model.title)")
            
            self.navigateToMovieDetails(for: model)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
    }
    
    private func navigateToMovieDetails(for model: MovieListCellViewModel){
        
        let movieDescriptionModel: MovieDetailsModel = MovieDetailsModel(movieID: model.movieId, title: model.title, releaseDate: model.releaseDate, mostPopular: model.mostPopular, backdropImageUrl: model.backdropImageUrl, posterImageUrl: model.posterImageUrl, description: model.overview, vote_average: model.vote_average, vote_count: model.vote_count, original_language: model.original_language)
        
        let detailsVC: MovieDetailsViewController = ControllerFactory.generateMovieDetailsController(for: movieDescriptionModel)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
