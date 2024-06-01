//
//  MainScreenViewModel.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

@MainActor
final class MainViewModel: ObservableObject {
    private let apiProvider = APIProvider<RecipesEndpoint>()
    
    @Published private(set) var recipesList: [RecipeSearchResult.Recipe] = []
    
    init() {}
    
    func getRecipes() async throws {
        let data = try await apiProvider.getData(from: .searchForRecipes(searchFilter: "chiken"))
        let decodedResponse = try JSONDecoder().decode(RecipeSearchResult.self, from: data)
        recipesList = decodedResponse.hits.map({ $0.recipe })
    }
    
    func setTestData() {
        #if DEBUG
        recipesList = [] // TODO: Add test models
        #endif
    }
}
