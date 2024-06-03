//
//  ArticleEndpoint.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import Foundation

enum RecipesEndpoint: EndpointProtocol {
    case searchForRecipes(searchFilter: String)
    case searchNextPage(URL)
    
    var baseURL: String {
        return "https://api.edamam.com"
    }
    
    var absoluteURL: String {
        switch self {
        case .searchForRecipes:
            return baseURL + "/api/recipes/v2"
        case .searchNextPage(let url):
            return url.absoluteString
        }
    }
    
    var defaultParams: [String: String] {
        [
            "type": "public",
            "app_id": "5b859e8c",
            "app_key": "31f822ac8b4b2a5cd4902e6a6ce80a58"
        ]
    }
    
    var params: [String: String]? {
        switch self {
        case .searchForRecipes(let searchFilter):
            var params = defaultParams
            params["q"] = searchFilter
            return params
        case .searchNextPage(_):
            return nil
        }
    }
    
    var headers: [String: String] {
        return [
            "accept": "application/json",
            "Accept-Language": "en"
        ]
    }
}
