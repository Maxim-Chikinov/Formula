//
//  MainScreenView.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject var storage: Storage
    @StateObject var model: MainScreenViewModel
    @State var showError = false
    @State var lastError: String?
    
    var body: some View {
        NavigationView {
            ScrollView {
                RecipesList(
                    model: model,
                    onScrolledAtBottom: {
                        onScrolledAtBottom()
                    }, 
                    isLoading: model.state.canLoadNextPage
                )
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 60, trailing: 0))
            }
            .background(storage.theame == 0 ? Color.white : Color.black.opacity(0.9))
            .navigationTitle("Recipes List")
        }
        .task {
            do {
                try await model.fetchRecipes(searchFilter: "Meet")
            } catch {
                lastError = "\(error.localizedDescription)"
                showError.toggle()
            }
        }
        .alert(lastError ?? "", isPresented: $showError) {}
    }
    
    private func onScrolledAtBottom() {
        Task {
            do {
                try await model.fetchNextPage()
            } catch {
                lastError = "\(error.localizedDescription)"
                showError.toggle()
            }
        }
    }
}

#Preview {
    let model = MainScreenViewModel()
    model.setTestData()
    let view = MainScreenView(model: model)
    return view
}
