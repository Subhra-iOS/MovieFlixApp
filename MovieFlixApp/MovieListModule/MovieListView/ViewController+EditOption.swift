//
//  ViewController+EditOption.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 18/11/21.
//

import Foundation
import UIKit

extension ViewController{
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if let list: [MovieListCellViewModel] = self.movieList {
            let editList = list.compactMap { (model) -> MovieListCellViewModel in
                var item = model
                item.isDeleteHidden = !editing
                return item
            }
            self.updateEdit(list: editList)
        }
        
    }
    //MARK:------Delete movie item from list and UICollection View-------//
    func delete(item: MovieListCellViewModel){
        if let list: [MovieListCellViewModel] = self.movieList,
           let rowIndex : Int = list.firstIndex(where: {$0.movieId == item.movieId}){
            self.removeMovieItem(at: rowIndex)
            let indexPath : IndexPath = IndexPath(item: rowIndex, section: 0)
            self.moviesColletionView.performBatchUpdates { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.moviesColletionView.deleteItems(at: [indexPath])
            } completion: { _ in
                
            }
        }
        
    }
    
}
