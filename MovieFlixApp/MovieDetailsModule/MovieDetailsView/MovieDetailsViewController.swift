//
//  MovieDetailsViewController.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 17/11/21.
//

import UIKit

let detailsCollectionViewCell = "DetailsCollectionViewCell"

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieDetailsCollectionView: UICollectionView!
   
    private(set) var detailsCellViewModel: MovieDetailsCellViewModel?
    private var viewModel: MovieDetailsViewModel!
    
    required init?(coder: NSCoder,
                   movie: MovieDetailsModel) {
        super.init(coder: coder)
        self.loadDetailsViewModel(for: movie)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerDetailsColletionViewCell()
        self.detailsCollectionViewLayoutSetup()
        
    }
    
    private func registerDetailsColletionViewCell(){
        
        self.movieDetailsCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: detailsCollectionViewCell)
        
    }
    //MARK:------Load details view model----------//
    private func loadDetailsViewModel(for item: MovieDetailsModel){
        self.viewModel = MovieDetailsViewModel(movie: item)
        self.viewModel.loadDetails { (model) in
            guard model.movieID > 0 else{ return }
            self.detailsCellViewModel = model
        }
    }
    

}
