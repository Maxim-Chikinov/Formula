//
//  RecipesList.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

struct RecipesList: View {
    @ObservedObject var model: MainScreenViewModel
    @EnvironmentObject var storage: Storage
    @State private var isLoading: Bool = false
    @State private var startAnimation = false
    let onScrolledAtBottom: () -> Void
    let onDetailDissapear: (() -> Void)?
    
    var columns = [GridItem(.adaptive(minimum: 140), spacing: 10, alignment: .center)]
    
    var body: some View {
        if model.recipesList.count != 0 {
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(model.recipesList.sorted(by: storage.displayOrderType.predicate())) { recipe in
                        if shouldShowOnlyFavourite(recipe: recipe) {
                            NavigationLink(destination: {
                                let model = RecipeDetailViewModel()
                                model.recipe = recipe
                                return RecipeDetailView(model: model)
                                    .onDisappear(perform: {
                                        onDetailDissapear?()
                                    })
                            }, label: {
                                RecipeCard(
                                    recipe: .constant(recipe),
                                    onFavourite: {
                                        model.changeFavourite(for: recipe)
                                    })
                                .onAppear {
                                    if model.recipesList.last == recipe && !storage.showFavouriteOnly {
                                        onScrolledAtBottom()
                                        isLoading = true
                                    }
                                }
                            })
                            .buttonStyle(ScaleButtonStyle())
                        }
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
    
    func shouldShowOnlyFavourite(recipe: RecipeSearchResult.Recipe) -> Bool {
        return recipe.isFavourite || !storage.showFavouriteOnly
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
        onScrolledAtBottom: {},
        onDetailDissapear: nil
    )
}
