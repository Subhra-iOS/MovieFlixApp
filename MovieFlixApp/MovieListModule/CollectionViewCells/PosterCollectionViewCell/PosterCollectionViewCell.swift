//
//  PosterCollectionViewCell.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import UIKit
import Combine

class PosterCollectionViewCell: UICollectionViewCell, ImageReloadProtocol {

    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterActivity: UIActivityIndicatorView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDetails: UILabel!
    
    private var cellIdentifier: String!
    private var url: String?
    private var fileStorePath: String!
    
   // private(set) var publisher = PassthroughSubject<String, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.posterImageView.layer.cornerRadius = 8
        self.posterImageView.clipsToBounds = true
        self.posterImageView.contentMode = .scaleAspectFill
    }
    
    var cellModel: MovieListCellViewModel?{
        didSet{
            self.movieTitle.text = cellModel?.title
            self.movieDetails.text = cellModel?.overview
            self.cellIdentifier = String(cellModel?.movieId ?? 0)
            self.url = cellModel?.posterImageUrl
            if let model = cellModel{
                self.fileStorePath = self.storePath(model)
            }
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
    
    func reloadImage(){
        self.posterImageView.image = nil
        self.posterImageView.backgroundColor = UIColor.black
        
        guard let _cellViewModel = self.cellModel,
              _cellViewModel.movieId > 0 ,
              self.fileStorePath.count > 0 else { return }
        
        guard let url = self.url else {
            return
        }
        
       // print("\(String(describing: self.fileStorePath))")
        
        self.posterActivity.startAnimating()
        self.cellModel?.downloadRemoteFileWith(imageUrl: url,
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

