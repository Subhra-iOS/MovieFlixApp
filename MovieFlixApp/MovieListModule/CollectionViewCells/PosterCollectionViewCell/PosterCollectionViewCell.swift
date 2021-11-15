//
//  PosterCollectionViewCell.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterActivity: UIActivityIndicatorView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
