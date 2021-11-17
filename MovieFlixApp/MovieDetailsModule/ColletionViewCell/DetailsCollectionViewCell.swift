//
//  DetailsCollectionViewCell.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 17/11/21.
//

import UIKit
import Cosmos

class DetailsCollectionViewCell: UICollectionViewCell, ImageReloadProtocol {
    
    @IBOutlet weak private var releaseDateLabel: UILabel!
    @IBOutlet weak private var ratingView: CosmosView!
    @IBOutlet weak private var movieImgView: UIImageView!
    @IBOutlet weak private var activityView: UIActivityIndicatorView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    private var cellIdentifier: String!
    private var url: String?
    private var fileStorePath: String!
    
    var cellViewModel: MovieDetailsCellViewModel? {
        
        didSet{
            self.titleLabel.text = cellViewModel?.title
            self.releaseDateLabel.text = cellViewModel?.releaseDate
            self.ratingView.rating = cellViewModel?.vote_average ?? 0.0
            self.descriptionLabel.text = cellViewModel?.description
            self.cellIdentifier = String(cellViewModel?.movieID ?? 0)
            self.url = cellViewModel?.backdropImageUrl
            if let model = cellViewModel{
                self.fileStorePath = self.storePath(model)
            }
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private let storePath:(MovieDetailsCellViewModel) -> String = { model in
        
        guard model.movieID > 0 else{
            return ""
        }
        let _fileExtension: String = model.backdropImageUrl.fileExtension()
        let _fileName: String = model.backdropImageUrl.fileName()
        return MFCommon().fetchFileStorePath(fileId: String(model.movieID), fileExtension: _fileExtension, fileName: _fileName)
    }
    
    func reloadImage(){
        
        self.movieImgView.image = nil
        self.movieImgView.backgroundColor = UIColor.black
        
        guard let _cellViewModel = self.cellViewModel,
              _cellViewModel.movieID > 0 ,
              self.fileStorePath.count > 0 else { return }
        
        guard let url = self.url else {
            return
        }
        
        self.activityView.startAnimating()
        _cellViewModel.downloadRemoteFileWith(shared: MFCommon(),
                                              imageUrl: url,
                                              path: self.fileStorePath,
                                              fileId: self.cellIdentifier) { [weak self] (state, fileStorePath, taskIdentifier) in
            
            guard  let weakSelf = self, let currentID: String = taskIdentifier,  weakSelf.cellIdentifier.isEqual(currentID) else {
                return
            }
            
            DispatchQueue.main.async{
                weakSelf.activityView.stopAnimating()
                if  let image: UIImage = UIImage(contentsOfFile: fileStorePath ?? ""){
                    weakSelf.movieImgView.image = nil
                    weakSelf.movieImgView.image = image
                    weakSelf.movieImgView.backgroundColor = UIColor.clear
                }else{
                    weakSelf.movieImgView.backgroundColor = UIColor.black
                }
            }
            
        }
    }

    

}
