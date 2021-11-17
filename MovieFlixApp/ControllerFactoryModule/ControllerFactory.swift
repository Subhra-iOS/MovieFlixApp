//
//  ControllerFactory.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 17/11/21.
//

import Foundation
import UIKit

struct Controllerfactory {
    static private var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    //MARK:-------Movie details viewcontroller factory method--------//
    static func generateMovieDetailsController(for movie: MovieDetailsModel) -> MovieDetailsViewController{
        let detailVC: MovieDetailsViewController = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") { (coder) -> MovieDetailsViewController? in
            return MovieDetailsViewController(coder: coder, movie: movie)
        }
        return detailVC
    }
}
