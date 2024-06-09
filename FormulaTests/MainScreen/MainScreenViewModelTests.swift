//
//  MainScreenViewModelTests.swift
//  FormulaTests
//
//  Created by Chikinov Maxim on 09.06.2024.
//

import Foundation
import XCTest
@testable import Formula

class MainScreenViewModelTests: XCTestCase {
    
    private var sut: MainScreenViewModel!
    private var apiProvider: APIProvider<RecipesEndpoint>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        apiProvider = APIProvider<RecipesEndpoint>()
        sut = MainScreenViewModel(apiProvider: apiProvider)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_initialState_isEmpty() {
        let list = sut.state.recipesList
        XCTAssertEqual(list.count, 0)
    }
    
    func testSetTestData() {
        sut.setTestData()
        let list = sut.state.recipesList
        XCTAssertEqual(list.count, 1, "Set test data")
    }
    
    func testFetchRecepes() async throws {
        try await sut.fetchRecipes(searchFilter: "Meet")
        let list = sut.state.recipesList
        XCTAssertEqual(list.count, 20, "Load recepice")
    }
    
    func testFetchNextPageRecepes() async throws {
        try await sut.fetchRecipes(searchFilter: "Meet")
        try await sut.fetchNextPage()
        let list = sut.state.recipesList
        XCTAssertGreaterThan(list.count, 20, "Load next page recepice")
    }
    
    func testWrongRecepiceLoad() async throws {
        let apiProvider: any APIProviderProtocol<RecipesEndpoint>
        apiProvider = MOCKAPIProvider<RecipesEndpoint>(data: Data())
        let sut = MainScreenViewModel(apiProvider: apiProvider)
        
        do {
            try await sut.fetchRecipes(searchFilter: "Meet")
            let list = sut.state.recipesList
            XCTAssertEqual(list.count, 0, "Get bad resonse")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
