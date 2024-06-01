//
//  RecipesList.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

struct RecipesList: View {
    @ObservedObject var model: MainViewModel
    
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 15)]
    
    var body: some View {
        if model.recipesList.count > 0 {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(model.recipesList, id: \.shareAs) { recipe in
                    RecipeCard(recipe: recipe)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        } else {
            ProgressView()
        }
    }
}

#Preview {
    RecipesList(model: MainViewModel())
}
