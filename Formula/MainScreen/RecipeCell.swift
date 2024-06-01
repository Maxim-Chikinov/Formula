//
//  CourseItem.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

struct RecipeCard: View {
    var recipe: RecipeSearchResult.Recipe
    
    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 80, alignment: .center)
                    .cornerRadius(6)
            } placeholder: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white.opacity(0.3))
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .progressViewStyle(.circular)
                }
                .frame(height: 80, alignment: .center)
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
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.white.opacity(0.2), lineWidth: 0.5)
                    .blendMode(.overlay))
        .shadow(color: Color.black.opacity(0.4), radius: 8)
    }
}

#Preview {
    var model = RecipeSearchResult.Recipe.init()
    model.image = ""
    model.label = "Some recipe label"
    model.healthLabels = ["Some", "recipe", "label"]
    return RecipeCard(recipe: model)
        .frame(width: 220, height: 200, alignment: .center)
}
