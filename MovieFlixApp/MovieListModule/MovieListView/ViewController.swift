//
//  ViewController.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel: MovieListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadViewModel()
    }

    private func loadViewModel(){
        self.viewModel = MovieListViewModel(serviceManager: ListServiceManager(apiKey: API.Key.api_Key))
       // self.viewModel?.moviePublisher.
    }

}

