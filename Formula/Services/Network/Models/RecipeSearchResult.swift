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
    let hits: [Hit]
    
    init() {
        from = 0
        to = 0
        count = 0
        hits = []
    }
    
    struct Hit: Decodable, Identifiable {
        
        var id: String {
            recipe.shareAs
        }
        
        var recipe: Recipe
    }
    
    struct Recipe: Decodable, Identifiable {
        
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
    }
}
