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
    @State var isLoading: Bool = false
    @State private var startAnimation = false
    
    var columns = [GridItem(.adaptive(minimum: 140), spacing: 10, alignment: .center)]
    
    var body: some View {
        if model.state.recipesList.count != 0 {
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(model.state.recipesList, id: \.id) { recipe in
                        NavigationLink(destination: {
                            let model = RecipeDetailViewModel()
                            model.recipe = recipe
                            return RecipeDetailView(model: model)
                        }, label: {
                            RecipeCard(recipe: recipe, onFavourite: {
                                model.changeFavourite(for: recipe)
                            })
                            .onAppear {
                                if model.state.recipesList.last == recipe {
                                    onScrolledAtBottom()
                                    isLoading = true
                                }
                            }
                        })
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
                .opacity(startAnimation ? 1 : 0)
                .offset(CGSize(width: 0, height: startAnimation ? 0 : -20))
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
                .animation(.bouncy, value: startAnimation)
                .onAppear(perform: {
                    startAnimation = true
                })
                
                if isLoading {
                    InfiniteProgressView().frame(width: 100, height: 100)
                }
            }
        } else {
            InfiniteProgressView().frame(width: 100, height: 100)
        }
    }
}

#Preview {
    let apiProvider = APIProvider<RecipesEndpoint>()
    let model = TestMainScreenViewModel(apiProvider: apiProvider)
    
    Task {
        try await model.fetchRecipes(searchFilter: "")
    }

    return RecipesList(
        model: model,
        onScrolledAtBottom: {}
    )
}
