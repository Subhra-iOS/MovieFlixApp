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
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
    }
    
}
