//
//  String+Extension.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 16/11/21.
//

import Foundation

extension String{
    
    func fileExtension() -> String {
        
        if let fileExtension = NSURL(fileURLWithPath: self).pathExtension {
            return fileExtension
        } else {
            return ""
        }
    }
    
    func fileName() -> String {
        
        if let deleteFileExtension = NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent{
            
            return deleteFileExtension
            
        } else {
            return ""
        }
    }

    
}
