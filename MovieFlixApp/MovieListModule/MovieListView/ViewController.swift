//
//  ViewController.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import UIKit
import Combine

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
        self.setEditOption()
    }
    
    private func setEditOption(){
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    private func registerColletionViewCells(){
        
        self.moviesColletionView.register(UINib(nibName: "BackdropCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: backdropCellIdentifier)
        self.moviesColletionView.register(UINib(nibName: "PosterCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: posterCellIdentifier)
        
    }
    //MARK:--------Load View Model-------//
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
    
    //MARK:---------Update Movie List on search-------//
    func updateSearch(list: [MovieListCellViewModel]){
        self.movieList = list
        self.moviesColletionView.reloadData()
    }
    //MARK:------Update Movie List on edit mode enable/disable-----//
    func updateEdit(list: [MovieListCellViewModel]){
        self.movieList = list
        self.moviesColletionView.reloadItems(at: self.moviesColletionView.indexPathsForVisibleItems)
    }
    
    //MARK:------Remove movie item from list array-------//
    func removeMovieItem(at index: Int){
        if var list: [MovieListCellViewModel] = self.movieList,
           index < list.count {
            list.remove(at: index)
            self.movieList = list
        }
    }
    
    deinit {
        print("ViewController  deinit")
    }
    
}
