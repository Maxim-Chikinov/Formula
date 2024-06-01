//
//  MainScreenView.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject var model: MainViewModel
    @State var showError = false
    @State var lastError: String?
    
    var body: some View {
        NavigationView {
            ScrollView {
                RecipesList(model: model)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 60, trailing: 0))
            }
            .navigationTitle("Recipes List")
        }
        .task {
            do {
                try await model.getRecipes()
            } catch {
                lastError = "\(error.localizedDescription)"
                showError.toggle()
            }
        }
        .alert(lastError ?? "", isPresented: $showError) {}
    }
}

#Preview {
    let model = MainViewModel()
    model.setTestData()
    let view = MainScreenView(model: model)
    return view
}
