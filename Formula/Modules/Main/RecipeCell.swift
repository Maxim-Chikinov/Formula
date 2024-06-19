//
//  CourseItem.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI
import NukeUI

struct RecipeCard: View {
    var recipe: RecipeSearchResult.Recipe
    var onFavourite: (() -> ())?
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topTrailing) {
                LazyImage(
                    url: URL(string: recipe.image),
                    transaction: Transaction(animation: .default)) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else {
                            Rectangle().fill(Color.black.opacity(0.1))
                        }
                    }
                    .frame(height: 80)
                    .clipped()
                    .cornerRadius(12)
                
                HeartView(isSelect: recipe.isFavourite) {
                    onFavourite?()
                }
                .frame(width: 30, height: 30)
                .padding(8)
            }
            
            Text(recipe.label)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            Text("\(recipe.healthLabels.joined(separator: " • "))")
                .font(.caption)
                .foregroundColor(Color.white.opacity(0.6))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .padding(16)
        .frame(height: 217, alignment: .top)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottomLeading)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.white.opacity(1), lineWidth: 0.5)
                .blendMode(.overlay)
        )
        .shadow(color: Color.black.opacity(0.4), radius: 8)
    }
}

#Preview {
    var recipe = RecipeSearchResult.Recipe()
    recipe.image = "https://wallpapers.com/images/hd/healthy-food-background-chh9nlqxwcyl1t06.jpg"
    recipe.label = "Some recipe label"
    recipe.healthLabels = ["Some", "recipe", "label"]
    
    return RecipeCard(recipe: recipe)
        .frame(width: 220, height: 200, alignment: .center)
}
