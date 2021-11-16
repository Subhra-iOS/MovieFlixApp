//
//  ViewController+ColletionViewDataSource.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 16/11/21.
//

import Foundation

import Foundation
import UIKit

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let items: [MovieListCellViewModel] = self.movieList, items.count > 0 {
            return items.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if let list: [MovieListCellViewModel] = self.movieList,
           list.count > 0 {
            
            let movie : MovieListCellViewModel = list[indexPath.item]
            switch movie.mostPopular {
                case .popular:
                    if let cell : BackdropCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: backdropCellIdentifier, for: indexPath) as? BackdropCollectionViewCell {
                        
                        cell.cellModel = movie
                        cell.reloadImage()
                        return cell
                    }
                case .average:
                    if let cell : PosterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: posterCellIdentifier, for: indexPath) as? PosterCollectionViewCell {
                        
                        cell.cellModel = movie
                        cell.reloadImage()
                        return cell
                    }
            }
            
        }
        return UICollectionViewCell()
    }
    
}

