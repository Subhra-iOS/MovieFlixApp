//
//  BackdropCollectionViewCell.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import UIKit
import Combine

class BackdropCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak private var backdropContainerView: UIView!
    @IBOutlet weak private var backdropImageView: UIImageView!
    @IBOutlet weak private var backdropImgActivity: UIActivityIndicatorView!
    
    @IBOutlet weak private var popularMovieDeleteBtn: UIButton!
    private(set) var popularPublisher = PassthroughSubject<MovieListCellViewModel, Never>()
    
    private var cellIdentifier: String!
    private var url: String?
    private var fileStorePath: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backdropImageView.layer.cornerRadius = 8
        self.backdropImageView.clipsToBounds = true
        self.backdropImageView.contentMode = .scaleAspectFill
        self.backdropContainerView.layer.cornerRadius = 8
        self.popularMovieDeleteBtn.isHidden = true
    }
    
    var popularMovieCellViewModel: MovieListCellViewModel?{
        didSet{
            self.cellIdentifier = String(popularMovieCellViewModel?.movieId ?? 0)
            self.url = popularMovieCellViewModel?.backdropImageUrl
            self.popularMovieDeleteBtn.isHidden = popularMovieCellViewModel?.isDeleteHidden ?? true
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
    
    //MARK:--------Delete Movie Cell--------//
    @IBAction func didTapToDeletePopularMovieElementCell(_ sender: Any) {
        if let cellModel: MovieListCellViewModel = popularMovieCellViewModel{
            self.popularPublisher.send(cellModel)
        }
    }
    
//    func setEditMode(on: Bool){
//        self.popularMovieDeleteBtn.isHidden = !on
//    }
//
//    override var isSelected: Bool {
//        didSet {
//            popularMovieDeleteBtn.isHidden = !isSelected
//        }
//    }

}

extension BackdropCollectionViewCell: ImageReloadProtocol{
    
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
