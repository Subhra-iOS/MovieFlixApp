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

    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var moviesColletionView: UICollectionView!
    
    private var viewModel: MovieListViewModel!
    private(set) var movieList: [MovieListCellViewModel]?
    private(set)var tempSearchArray: [MovieListCellViewModel]?
    
    
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
        self.viewModel.updateColletionList(closure: { [weak self] (models) in
            guard let weakSelf = self else {
                return
            }
            
            guard let remoteModels: [MovieListCellViewModel] = models?.filter({$0.movieId != 0}),
                  remoteModels.count > 0 else{ return }
            
            weakSelf.movieList = remoteModels
            weakSelf.tempSearchArray = remoteModels
            weakSelf.generateSearchMoviesModelswith(list: remoteModels)
            weakSelf.moviesColletionView.reloadData()
        })
    }
    
    func update(list: [MovieListCellViewModel]){
        self.movieList = list
        self.moviesColletionView.reloadData()
    }

}


