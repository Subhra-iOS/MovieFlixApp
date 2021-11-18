//
//  MovieDetailsViewController+CollectionViewDataSource.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 17/11/21.
//

import Foundation
import UIKit

//MARK:------UICollectionView DataSource---------//
extension MovieDetailsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if let movie: MovieDetailsCellViewModel = self.detailsCellViewModel,
           let cell : DetailsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: detailsCollectionViewCell, for: indexPath) as? DetailsCollectionViewCell{
            
            cell.cellViewModel = movie
            cell.reloadImage()
            
            return cell
            
        }
        return UICollectionViewCell()
    }
    
}
