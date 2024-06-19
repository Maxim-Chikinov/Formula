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
                
                Text(model.recipe.label)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                    .padding()
                
                
                ScrollView(.horizontal) {
                    LazyHStack(content: {
                        ForEach(model.recipe.healthLabels, id: \.self) { label in
                            Text(label)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    })
                    .padding()
                }
                
                Text(model.recipe.healthLabels.joined(separator: ", "))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .multilineTextAlignment(.leading)
                    .font(.callout)
                    .padding()
            }
            .padding(.init(top: 0, leading: 0, bottom: 80, trailing: 0))
            .setNavigationBar(title: "Recipe Details")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    HeartView(isSelect: $model.recipe.isFavourite) { _ in
                        var recipe = model.recipe
                        recipe.isFavourite.toggle()
                        model.changeFavourite(for: recipe)
                    }
                }
            })
            .onAppear(perform: {
                model.update()
            })
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
