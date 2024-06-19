//
//  MainScreenViewModel.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

class MainScreenViewModel: ObservableObject {
    struct State {
        var response: RecipeSearchResult = .init()
        var recipesList: [RecipeSearchResult.Recipe] = []
        var page: Int = 0
        var canLoadNextPage = true
    }
    
    @Published var state = State()
    @AppStorage("FavouriteRecipesList") var favouriteRecipesList: [String] = []
    
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
    
    func refresh() async throws {
        let data = try await apiProvider.getData(from: .searchForRecipes(searchFilter: "Meet"))
        let decodedResponse = try JSONDecoder().decode(RecipeSearchResult.self, from: data)
        await onReceive(reload: true, decodedResponse)
    }
    
    @MainActor
    fileprivate func onReceive(reload: Bool = false, _ response: RecipeSearchResult) {
        let batch = response.hits
            .map({ $0.recipe })
            .map({ recipe in
            var recipe = recipe
            recipe.isFavourite = favouriteRecipesList.contains(recipe.label)
            return recipe
        })
        if reload {
            state = State()
        }
        state.response = response
        state.recipesList += batch
        state.page += response.count
        state.canLoadNextPage = response.to != response.count
    }
    
    func changeFavourite(for recepe: RecipeSearchResult.Recipe) {
        if favouriteRecipesList.contains(recepe.label) {
            favouriteRecipesList.removeAll(where: {$0 == recepe.label})
        } else {
            favouriteRecipesList.append(recepe.label)
        }
    }
}

class TestMainScreenViewModel: MainScreenViewModel {
    func getTestResult() -> RecipeSearchResult {
        var result = RecipeSearchResult()
        var resipe = RecipeSearchResult.Recipe()
        for _ in 0...20 {
            let randomNumber = (0...100_000).randomElement() ?? 0
            resipe.label = "Test recipre label \(randomNumber)"
            resipe.shareAs = "\(randomNumber)"
            resipe.healthLabels = randomNumber % 2 == 0 ? ["Fit", "Meet", "Foo", "Bar"] : ["Fit", "Meet", "Foo", "Bar", "Fit", "Meet", "Foo", "Bar"]
            resipe.image = "https://i.pinimg.com/originals/ae/06/aa/ae06aa53c7e7de92f529e739e38da8f4.png"
            result.hits.append(.init(recipe: resipe))
        }
        return result
    }
    
    override func fetchNextPage() async throws {
        try await Task.sleep(for: .seconds(2))
        await onReceive(getTestResult())
    }
    
    override func fetchRecipes(searchFilter: String, from: Int = 0) async throws {
        try await Task.sleep(for: .seconds(2))
        await onReceive(getTestResult())
    }
    
    override func refresh() async throws {
        try await Task.sleep(for: .seconds(1))
        self.state = State()
        await onReceive(getTestResult())
    }
}
