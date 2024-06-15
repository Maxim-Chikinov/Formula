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
    
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        if model.state.recipesList.count != 0 {
            ZStack {
                LazyVGrid(columns: columns, spacing: 20) {
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
    let apiProvider = APIProvider<RecipesEndpoint>()
    let model = TestMainScreenViewModel(apiProvider: apiProvider)
    
    Task {
        try await model.fetchRecipes(searchFilter: "")
    }

    return RecipesList(
        model: model,
        onScrolledAtBottom: {},
        isLoading: false
    )
}
