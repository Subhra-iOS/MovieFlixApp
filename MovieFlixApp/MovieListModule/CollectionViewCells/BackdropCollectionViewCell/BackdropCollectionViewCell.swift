//
//  BackdropCollectionViewCell.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import UIKit

class BackdropCollectionViewCell: UICollectionViewCell, ImageReloadProtocol {

    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var backdropImgActivity: UIActivityIndicatorView!
    
    private var cellIdentifier: String!
    private var url: String?
    private var fileStorePath: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backdropImageView.layer.cornerRadius = 8
        self.backdropImageView.clipsToBounds = true
        self.backdropImageView.contentMode = .scaleAspectFill
    }
    
    var popularMovieCellViewModel: MovieListCellViewModel?{
        didSet{
            self.cellIdentifier = String(popularMovieCellViewModel?.movieId ?? 0)
            self.url = popularMovieCellViewModel?.backdropImageUrl
            if let model = popularMovieCellViewModel{
                self.fileStorePath = self.storePath(model)
            }
        }
    }
    
    private let storePath:(MovieListCellViewModel) -> String = { model in
        
        guard model.movieId > 0 else{
            return ""
        }
        let _fileExtension: String = model.backdropImageUrl.fileExtension()
        let _fileName: String = model.backdropImageUrl.fileName()
        return MFCommon().fetchFileStorePath(fileId: String(model.movieId), fileExtension: _fileExtension, fileName: _fileName)
    }
    
    func reloadImage(){
        
        self.backdropImageView.image = nil
        self.backdropImageView.backgroundColor = UIColor.black
        
        guard let _cellViewModel = self.popularMovieCellViewModel,
              _cellViewModel.movieId > 0 ,
              self.fileStorePath.count > 0 else { return }
       
        guard let url = self.url else {
            return
        }
        
        self.backdropImgActivity.startAnimating()
        _cellViewModel.downloadRemoteFileWith(shared: MFCommon(),
                                              imageUrl: url,
                                              path: self.fileStorePath,
                                              fileId: self.cellIdentifier) { [weak self] (state, fileStorePath, taskIdentifier) in
            
            guard  let weakSelf = self, let currentID: String = taskIdentifier,  weakSelf.cellIdentifier.isEqual(currentID) else {
                return
            }
            
            DispatchQueue.main.async{
                weakSelf.backdropImgActivity.stopAnimating()
                if  let image: UIImage = UIImage(contentsOfFile: fileStorePath ?? ""){
                    weakSelf.backdropImageView.image = nil
                    weakSelf.backdropImageView.image = image
                    weakSelf.backdropImageView.backgroundColor = UIColor.clear
                }else{
                    weakSelf.backdropImageView.backgroundColor = UIColor.black
                }
            }
            
        }
    }

}
