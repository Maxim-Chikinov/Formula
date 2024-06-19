//
//  RecipeDetailView.swift
//  Formula
//
//  Created by Chikinov Maxim on 16.06.2024.
//

import SwiftUI
import NukeUI

struct RecipeDetailView: View {
    @StateObject var model: RecipeDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text(model.recipe.label)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                LazyImage(
                    url: URL(string: model.recipe.image),
                    transaction: Transaction(animation: .default)
                ) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
                        Rectangle().fill(Color.black.opacity(0.1))
                    }
                }
                .frame(height: 200)
                .clipped()
            }
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Recipe detail")
        }
    }
}

#Preview {
    let model = RecipeDetailViewModel()
    var recipe = RecipeSearchResult.Recipe()
    recipe.label = "Recipe label"
    recipe.image = "https://humanitarianpartnershipconference.files.wordpress.com/2016/09/nicolette-recipe-book-step-1.jpg"
    model.recipe = recipe
    return NavigationStack {
        RecipeDetailView(model: model)
            .navigationTitle("Recipe")
    }
}
