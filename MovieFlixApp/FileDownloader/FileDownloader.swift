//
//  FileDownloader.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 16/11/21.
//

import Foundation

typealias FileDownloaderHandler = (_ status : Bool, _ fileStorePath : String?, _  identifier: String?) -> Void

class FileDownloader : NSObject{
    private var sharedSessionTask : URLSessionTask?
    private var _url: String?
    private var storePath: String?
    public   var operationStateHandler : FileDownloaderHandler?
    private var identifier: String?
    
    /// Shared URL Session
    /// - Author: Subhra Roy
    private lazy  var sharedSession : URLSession? = {
        let session : URLSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        return session
    }()
    
    convenience init(url: String, filePath: String, taskIdentifier: String) {
        self.init()
        self._url = url
        self.storePath = filePath
        self.identifier = taskIdentifier
    }
    
    private override init() {
        super.init()
    }
    
    //MARK:-------Download file --------------//
    func downloadFile(){
        if let currentSession : URLSession = self.sharedSession , let newUrl: String = self._url{
            let request: URLRequest = URLRequest(url: URL(string: newUrl)!)
            self.sharedSessionTask = currentSession.dataTask(with: request)
            self.sharedSessionTask?.resume()
        }else{
            
        }
    }
    
    private func finishTask() -> Void{
        if let sessionTask  : URLSessionTask = self.sharedSessionTask{
            sessionTask.cancel()
        }
        if let sharedSession : URLSession = self.sharedSession{
            sharedSession.finishTasksAndInvalidate()
        }
    }
    
    func cancelSession() -> Void{
        if let session  : URLSessionTask = self.sharedSessionTask{
            session.cancel()
        }
        
        if let sharedSession : URLSession = self.sharedSession{
            sharedSession.invalidateAndCancel()
        }
    }
    
    deinit {
        print("FileDownloader  dealloc")
    }
    
}

extension  FileDownloader: URLSessionDataDelegate,URLSessionDownloadDelegate{
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Swift.Void){
        
        if(dataTask.state == URLSessionTask.State.canceling) {
            
            self.finishTask()
            completionHandler(.cancel)
            return
            
        }else{
            
            if response is HTTPURLResponse {
                
                if let urlResponse : HTTPURLResponse = response as? HTTPURLResponse{
                    
                    let httpsResponse : HTTPURLResponse = urlResponse
                    let statusCode = httpsResponse.statusCode
                    
                    if statusCode == 200 {
                        
                        completionHandler(.becomeDownload)
                    }else{
                        
                        completionHandler(.cancel)
                    }
                }
            }else{
                self.finishTask()
                completionHandler(.cancel)
            }
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome downloadTask: URLSessionDownloadTask){
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data){
        
        if(dataTask.state == URLSessionTask.State.canceling) {
            return
        }else{}
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        
        let downLoadProgress = (Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))
        print("Download progress : \(downLoadProgress)")
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL){
        
        
        switch downloadTask.state {
            case .canceling, .suspended: break
            default:
                self.finishTask()
                
                if let storeFilePath : String = self.storePath, storeFilePath.count > 0 {
                    
                    let fileManager : FileManager = FileManager.default
                    if fileManager.fileExists(atPath: storeFilePath){
                        
                        do{
                            try fileManager.removeItem(at: URL(fileURLWithPath: storeFilePath))
                        }catch{
                            print("Fails to remove file")
                        }
                        
                    }
                    
                    do{
                        try fileManager.moveItem(at: location, to: URL(fileURLWithPath: storeFilePath))
                    }catch{
                        
                        print("Fails to move file")
                    }
                    
                    self.operationStateHandler?(true, self.storePath, self.identifier)
                    
                }
        }
                
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64){
        
        
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?){
        
        switch task.state {
            case .canceling, .suspended: break
            default:
                if let errorInfo = error{
                    
                    print("Session error: \(errorInfo.localizedDescription)")
                    
                    self.finishTask()
                    self.operationStateHandler?(false, self.storePath, self.identifier)
                }
                else{
                    
                }
        }
                
    }
    
}
