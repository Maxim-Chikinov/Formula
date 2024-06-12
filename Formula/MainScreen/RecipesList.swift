//
//  RecipesList.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

struct RecipesList: View {
    @ObservedObject var model: MainScreenViewModel
    let onScrolledAtBottom: () -> Void
    let isLoading: Bool
    @State private var startAnimation = false
    
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 15)]
    
    var body: some View {
        if model.state.recipesList.count != 0 {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(model.state.recipesList, id: \.id) { recipe in
                        RecipeCard(recipe: recipe).onAppear {
                            if model.state.recipesList.last == recipe {
                                onScrolledAtBottom()
                            }
                        }
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
                
                if isLoading {
                    ProgressView()
                }
            }
        } else {
            ProgressView().frame(width: 500, height: 500)
        }
    }
}

#Preview {
    let searchRecipesProvider = APIProvider<RecipesEndpoint>()
    return RecipesList(
        model: MainScreenViewModel(apiProvider: searchRecipesProvider),
        onScrolledAtBottom: {},
        isLoading: true
    )
}
