//
//  MainScreenViewModel.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

@MainActor
final class MainScreenViewModel: ObservableObject {
    struct State {
        var response: RecipeSearchResult = .init()
        var recipesList: [RecipeSearchResult.Recipe] = []
        var page: Int = 0
        var canLoadNextPage = true
    }
    
    @Published private(set) var state = State()
    
    private let apiProvider = APIProvider<RecipesEndpoint>()
    
    init() {}
    
    func fetchRecipes(searchFilter: String, from: Int = 0) async throws {
        let data = try await apiProvider.getData(from: .searchForRecipes(searchFilter: searchFilter))
        let decodedResponse = try JSONDecoder().decode(RecipeSearchResult.self, from: data)
        onReceive(decodedResponse)
    }
    
    func fetchNextPage() async throws {
        guard
            state.canLoadNextPage,
            let nextPageUrl = state.response.links.next?.nextPageUrl,
            let url = URL(string: nextPageUrl)
        else {
            return
        }
        let data = try await apiProvider.getData(from: .searchNextPage(url))
        let decodedResponse = try JSONDecoder().decode(RecipeSearchResult.self, from: data)
        onReceive(decodedResponse)
    }
    
    private func onReceive(_ response: RecipeSearchResult) {
        let batch = response.hits.map({ $0.recipe })
        state.response = response
        state.recipesList += batch
        state.page += response.count
        state.canLoadNextPage = response.to != response.count
    }
    
    func setTestData() {
        #if DEBUG
        state.recipesList = [] // TODO: Add test models
        #endif
    }
}
