//
//  MFCommon.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 16/11/21.
//

import Foundation

struct MFCommon {
    
    func fetchFileStorePath(fileId: String,
                                      fileExtension: String? = nil,
                                      fileName: String? = nil) -> String {
    
        let paths: String = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        var path: String = paths.appendingFormat("/Downloads/Movies/%@/", fileId)
      
        do{
            _ =  try createDirectoryIfNecessaryForPath(path: path)
        }catch{
            
        }
        
        if let _fileName : String = fileName, _fileName.count > 0, let _extension : String = fileExtension, _extension.count > 0 {
            path = path.appendingFormat("%@.%@", _fileName,_extension.replacingOccurrences(of: ".", with: ""))
        }else{
            path = ""
        }
        return  path
    }
    
    //MARK:---------Check or Create Directory If Necessary-------//
    private func createDirectoryIfNecessaryForPath(path : String) throws -> Bool {
        if !FileManager.default.fileExists(atPath: path) {
            do{
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: [:])
                return true
            }catch{
                throw  ServiceError.unableToProcess
            }
        }else{
            return true
        }
    }
    
    //MARK:------Check file existance------------//
    func isFileExistAt(_ path : String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            return  true
        }else{
            return  false
        }
    }
}
