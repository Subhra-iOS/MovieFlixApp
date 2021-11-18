//
//  ViewController+ColletionViewDataSource.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 16/11/21.
//


import Foundation
import UIKit

//MARK:--------UICollectionView DataSource functions-------//
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
                        
                        cell.popularMovieCellViewModel = movie
                        cell.reloadImage()
                        cell.popularPublisher.sink { [weak self] (cellModel) in
                            //print("\(cellModel.movieId)")
                            //print("\(cellModel.title)")
                            guard let weakSelf = self else{ return }
                            weakSelf.delete(item: cellModel)
                            
                        }.store(in: &obaservers)
                        return cell
                    }
                case .average:
                    if let cell : PosterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: posterCellIdentifier, for: indexPath) as? PosterCollectionViewCell {
                        
                        cell.avgMovieCellViewModel = movie
                        cell.reloadImage()
                        cell.averagePublisher.sink { [weak self] (cellModel) in
                           // print("\(cellModel.movieId)")
                            //print("\(cellModel.title)")
                            guard let weakSelf = self else{ return }
                            weakSelf.delete(item: cellModel)
                        }.store(in: &obaservers)
                        return cell
                    }
            }
            
        }
        return UICollectionViewCell()
    }
    
}

