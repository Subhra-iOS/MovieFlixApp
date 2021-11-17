//
//  CustomProtocols.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import Foundation

protocol ServiceProtocol {
    var serviceUrl : String? { get }
}

extension ServiceProtocol{
    
    func generateQueryString(baseUrl: String,
                             parameters: [String: String]? = nil) -> String? {
        
        let  urlString :  String = baseUrl
        let _url : URL = URL(string: urlString)!
        
        let _urlComponents = NSURLComponents(url: _url, resolvingAgainstBaseURL: false)
        
        guard let _component = _urlComponents else {
            
            return nil
        }
        
        if let _params = parameters {
            
            _component.queryItems = _params.map({ (key, value) -> URLQueryItem in
                
                return URLQueryItem(name: key, value: value)
                
            })
            
        }
        return _component.url?.absoluteString
        
    }
}

protocol ImageReloadProtocol {
    func reloadImage()
} 

protocol ImageDownloaderProtocol {
    func downloadRemoteFileWith(shared: MFCommon,
                                imageUrl: String,
                                path: String,
                                fileId: String,
                                completion: @escaping (_ status: Bool,
                                                       _ filePath: String?,
                                                       _ taskIdentifier: String?) -> Void) -> Void
}

extension ImageDownloaderProtocol{
    
    func downloadRemoteFileWith(shared: MFCommon,
                                imageUrl: String,
                                path: String,
                                fileId: String,
                                completion: @escaping (_ status: Bool,
                                                       _ filePath: String?,
                                                       _ taskIdentifier: String?) -> Void) -> Void{
        
        if shared.isFileExistAt(path){
            completion(true, path, fileId)
        }else{
            let fileDownloader: FileDownloader = FileDownloader(url: imageUrl, filePath: path, taskIdentifier: fileId)
            fileDownloader.downloadFile()
            fileDownloader.operationStateHandler = { ( status,  fileStorePath,  _identifier) in
                completion(status, fileStorePath, _identifier)
            }
        }
    }
}
