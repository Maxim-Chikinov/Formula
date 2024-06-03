//
//  Article.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import Foundation

struct RecipeSearchResult: Decodable, Identifiable {
    
    var id: String {
        hits.map({ $0.recipe.shareAs }).joined()
    }
    
    let from: Int
    let to: Int
    let count: Int
    let links: Links
    let hits: [Hit]
    
    init() {
        from = 0
        to = 0
        count = 0
        links = Links()
        hits = []
    }
    
    enum CodingKeys: String, CodingKey {
        case from
        case to
        case count
        case links = "_links"
        case hits
    }
    
    struct Links: Decodable {
        struct Next: Decodable {
            var nextPageUrl: String = ""
            
            enum CodingKeys: String, CodingKey {
                case nextPageUrl = "href"
            }
        }
        
        var next: Next?
        
        enum CodingKeys: String, CodingKey {
            case next = "next"
        }
    }
    
    struct Hit: Decodable, Identifiable {
        
        var id: String {
            recipe.shareAs
        }
        
        var recipe: Recipe
        
        enum CodingKeys: String, CodingKey {
            case recipe
        }
    }
    
    struct Recipe: Decodable, Identifiable, Equatable {
        
        var id: String {
            shareAs
        }
        
        var label: String
        var image: String
        var shareAs: String
        var healthLabels: [String]
        
        init() {
            label = ""
            image = ""
            shareAs = ""
            healthLabels = []
        }
        
        enum CodingKeys: String, CodingKey {
            case label
            case image
            case shareAs
            case healthLabels
        }
    }
}
