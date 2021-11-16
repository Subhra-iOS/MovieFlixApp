//
//  ViewController.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import UIKit

let posterCellIdentifier = "PosterCollectionViewCell"
let backdropCellIdentifier = "BackdropCollectionViewCell"

class ViewController: UIViewController {

    
    @IBOutlet weak var moviesColletionView: UICollectionView!
    private var viewModel: MovieListViewModel?
    private(set) var movieList: [MovieListCellViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.registerColletionViewCells()
        self.collectionViewLayoutSetup()
        self.loadViewModel()
    }
    
    private func registerColletionViewCells(){
        
        self.moviesColletionView.register(UINib(nibName: "BackdropCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: backdropCellIdentifier)
        self.moviesColletionView.register(UINib(nibName: "PosterCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: posterCellIdentifier)
    }

    private func loadViewModel(){
        self.viewModel = MovieListViewModel(serviceManager: ListServiceManager(apiKey: API.Key.api_Key))
        self.viewModel?.updateColletionList(closure: { [weak self] (models) in
            guard let weakSelf = self else {
                return
            }
            
            guard let remoteModels: [MovieListCellViewModel] = models?.filter({$0.movieId != 0}),
                  remoteModels.count > 0 else{ return }
            
            weakSelf.movieList = remoteModels
            weakSelf.moviesColletionView.reloadData()
        })
    }

}

extension ViewController{
    
    private func collectionViewLayoutSetup(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let sizeCollectionViewItem : CGSize = self.collectionViewitemSize(collectionView: self.moviesColletionView)
        
        layout.itemSize = CGSize(width: sizeCollectionViewItem.width, height: sizeCollectionViewItem.width + 45)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        
        self.moviesColletionView.setCollectionViewLayout(layout, animated: false)
        
    }
    
    private func collectionViewitemSize(collectionView:UICollectionView) -> CGSize{
        
        let sizeCollectionViewItem : CGSize = CGSize(width: (collectionView.frame.size.width ) - 20 , height: 0)
        return CGSize(width: sizeCollectionViewItem.width, height: sizeCollectionViewItem.width + 45)
        
    }
    
}

