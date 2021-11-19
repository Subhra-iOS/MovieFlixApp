//
//  PosterCollectionViewCell.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import UIKit
import Combine

class PosterCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak private var posterContainerView: UIView!
    @IBOutlet weak private var posterImageView: UIImageView!
    @IBOutlet weak private var posterActivity: UIActivityIndicatorView!
    @IBOutlet weak private var movieTitle: UILabel!
    @IBOutlet weak private var movieDetails: UILabel!
    
    @IBOutlet weak private var posterMovieDeleteBtn: UIButton!
    
    
    private var cellIdentifier: String!
    private var url: String?
    private var fileStorePath: String!
    
    private(set) var averagePublisher = PassthroughSubject<MovieListCellViewModel, Never>()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.posterImageView.layer.cornerRadius = 8
        self.posterImageView.clipsToBounds = true
        self.posterImageView.contentMode = .scaleAspectFill
        self.posterContainerView.layer.cornerRadius = 8
        self.posterMovieDeleteBtn.isHidden = true
    }
    
    var avgMovieCellViewModel: MovieListCellViewModel?{
        didSet{
            self.movieTitle.text = avgMovieCellViewModel?.title
            self.movieDetails.text = avgMovieCellViewModel?.overview
            self.cellIdentifier = String(avgMovieCellViewModel?.movieId ?? 0)
            self.url = avgMovieCellViewModel?.posterImageUrl
            self.posterMovieDeleteBtn.isHidden = avgMovieCellViewModel?.isDeleteHidden ?? true
            if let model = avgMovieCellViewModel{
                self.fileStorePath = self.storePath(model)
            }
        }
    }
    
    //MARK:--------Delete Movie Cell--------//
    @IBAction func didTapOnPopularMovieElementCell(_ sender: Any) {
        
        if let cellModel: MovieListCellViewModel = self.avgMovieCellViewModel {
            self.averagePublisher.send(cellModel)
        }
        
    }
    
    
    private let storePath:(MovieListCellViewModel) -> String = { model in
        
        guard model.movieId > 0 else{
            return ""
        }
        
        let _fileExtension: String = model.posterImageUrl.fileExtension()
        let _fileName: String = model.posterImageUrl.fileName()
        return MFCommon().fetchFileStorePath(fileId: String(model.movieId), fileExtension: _fileExtension, fileName: _fileName)
    }
    
    deinit {
       
        print("PosterCollectionViewCell deinit")
    }

}

extension PosterCollectionViewCell : ImageReloadProtocol{
    
    func reloadImage(){
        self.posterImageView.image = nil
        self.posterImageView.backgroundColor = UIColor.black
        
        guard let _cellViewModel = self.avgMovieCellViewModel,
              _cellViewModel.movieId > 0 ,
              self.fileStorePath.count > 0 else { return }
        
        guard let url = self.url else {
            return
        }
        
        // print("\(String(describing: self.fileStorePath))")
        
        self.posterActivity.startAnimating()
        _cellViewModel.downloadRemoteFileWith(shared: MFCommon(),
                                              imageUrl: url,
                                              path: self.fileStorePath,
                                              fileId: self.cellIdentifier) { [weak self] (state, fileStorePath, taskIdentifier) in
            
            guard  let weakSelf = self, let currentID: String = taskIdentifier,  weakSelf.cellIdentifier.isEqual(currentID) else {
                return
            }
            
            DispatchQueue.main.async{
                weakSelf.posterActivity.stopAnimating()
                if  let image: UIImage = UIImage(contentsOfFile: fileStorePath ?? ""){
                    weakSelf.posterImageView.image = nil
                    weakSelf.posterImageView.image = image
                    weakSelf.posterImageView.backgroundColor = UIColor.clear
                }else{
                    weakSelf.posterImageView.backgroundColor = UIColor.black
                }
            }
            
        }
    }
    
}

