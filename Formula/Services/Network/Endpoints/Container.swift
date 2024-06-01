//
//  Container.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import Foundation

class Container {
    static let jsonDecoder: JSONDecoder = JSONDecoder()
    
    static var weatherJSONDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return jsonDecoder
    }()
    
    /// News API key url: https://newsapi.org
    static let recipesAPIKey: String = "31f822ac8b4b2a5cd4902e6a6ce80a58"
}
