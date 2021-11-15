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
                return self.generateQueryString(baseUrl: API.Service.movies_baseUrl, parameters: [API.URLKeys.apiKey.rawValue : apiKey])
        }
    }

   
}
