//
//  MovieDetailsViewController+CollectionViewLayOut.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 17/11/21.
//

import Foundation
import UIKit

//MARK:--------UICollectionView FlowLayout---------//
extension MovieDetailsViewController{
    
    func detailsCollectionViewLayoutSetup(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let sizeCollectionViewItem : CGSize = self.collectionViewitemSize(collectionView: self.movieDetailsCollectionView)
        
        layout.itemSize = CGSize(width: sizeCollectionViewItem.width, height: sizeCollectionViewItem.width + 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        
        self.movieDetailsCollectionView.setCollectionViewLayout(layout, animated: false)
        
    }
    
    private func collectionViewitemSize(collectionView:UICollectionView) -> CGSize{
        
        let sizeCollectionViewItem : CGSize = CGSize(width: (collectionView.frame.size.width ) - 20 , height: 0)
        return CGSize(width: sizeCollectionViewItem.width, height: sizeCollectionViewItem.width + 200)
        
    }
    
}
