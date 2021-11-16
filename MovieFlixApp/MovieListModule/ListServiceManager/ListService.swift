//
//  ListService.swift
//  MovieFlixApp
//
//  Created by Subhra Roy on 15/11/21.
//

import Foundation



enum ListService{
    case url(String)
}

extension ListService: ServiceProtocol{
    var serviceUrl: String? {
        switch self {
            case .url(let apiKey):
                let listUrl = API.Service.movies_baseUrl + "now_playing"
                return self.generateQueryString(baseUrl: listUrl, parameters: [API.URLKeys.apiKey.rawValue : apiKey])
        }
    }

   
}
