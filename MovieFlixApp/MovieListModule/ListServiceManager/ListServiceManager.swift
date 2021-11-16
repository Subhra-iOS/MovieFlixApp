//
//  ListServiceManager.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import Foundation

struct ListServiceManager {
    
    private let apiKey: String 
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchList(completion: @escaping (Swift.Result<[MovieElement], ServiceError>) -> ()){
        
        guard let urlString: String = ListService.url(self.apiKey).serviceUrl,
              let url: URL = URL(string: urlString) else {
            completion(.failure(.noData))
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data,
                  error == nil else {
                completion(.failure(.invalid))
                return
            }
            
            if let list : MovieList = try? JSONDecoder().decode(MovieList.self, from: data),
               let result: [MovieElement] = list.results,
               result.count > 0 {
                completion(.success(result))
            }else{
                completion(.failure(.invalid))
            }
            
        }.resume()
        
    }
}
