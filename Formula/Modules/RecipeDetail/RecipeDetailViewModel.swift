//
//  RecipeDetailViewModel.swift
//  Formula
//
//  Created by Chikinov Maxim on 16.06.2024.
//

import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: RecipeSearchResult.Recipe = .init()
    
    func changeFavourite(for recepe: RecipeSearchResult.Recipe) {
        if UserDefault.favouriteRecipesList.contains(recepe.label) {
            UserDefault.favouriteRecipesList.removeAll(where: {$0 == recepe.label})
        } else {
            UserDefault.favouriteRecipesList.append(recepe.label)
        }
        update()
    }
    
    func update() {
        recipe.isFavourite = UserDefault.favouriteRecipesList.contains(recipe.label)
    }
}
