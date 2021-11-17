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
    private(set) var movieDesModel: MovieDetailsModel?
    
    required init?(coder: NSCoder,
                   movie: MovieDetailsModel?) {
        super.init(coder: coder)
        self.movieDesModel = movie
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
    

}
