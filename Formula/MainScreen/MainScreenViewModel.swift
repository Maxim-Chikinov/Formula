//
//  MainScreenViewModel.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

final class MainScreenViewModel: ObservableObject {
    struct State {
        var response: RecipeSearchResult = .init()
        var recipesList: [RecipeSearchResult.Recipe] = []
        var page: Int = 0
        var canLoadNextPage = true
    }
    
    @Published private(set) var state = State()
    
    private let apiProvider: any APIProviderProtocol<RecipesEndpoint>
    
    init(apiProvider: any APIProviderProtocol<RecipesEndpoint>) {
        self.apiProvider = apiProvider
    }
    
    func fetchRecipes(searchFilter: String, from: Int = 0) async throws {
        let data = try await apiProvider.getData(from: .searchForRecipes(searchFilter: searchFilter))
        let decodedResponse = try JSONDecoder().decode(RecipeSearchResult.self, from: data)
        await onReceive(decodedResponse)
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
        await onReceive(decodedResponse)
    }
    
    @MainActor
    private func onReceive(_ response: RecipeSearchResult) {
        let batch = response.hits.map({ $0.recipe })
        state.response = response
        state.recipesList += batch
        state.page += response.count
        state.canLoadNextPage = response.to != response.count
    }
    
    func setTestData() {
        #if DEBUG
        state.recipesList = [.init()] // TODO: Add test models
        #endif
    }
}
