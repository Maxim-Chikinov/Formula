//
//  RecipesList.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

struct RecipesList: View {
    @ObservedObject var model: MainViewModel
    @State private var startAnimation = false
    
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 15)]
    
    var body: some View {
        if model.recipesList.count > 0 {
            LazyVGrid(columns: columns) {
                ForEach(model.recipesList, id: \.id) { recipe in
                    RecipeCard(recipe: recipe)
                }
            }
            .opacity(startAnimation ? 1 : 0)
            .offset(CGSize(width: 0, height: startAnimation ? 0 : -20))
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .animation(.bouncy, value: startAnimation)
            .onAppear(perform: {
                startAnimation = true
            })
        } else {
            ProgressView()
                .frame(width: 500, height: 500)
        }
    }
}

#Preview {
    RecipesList(model: MainViewModel())
}
