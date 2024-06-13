//
//  MainScreenView.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI
import ActivityKit

struct MainScreenView: View {
    @EnvironmentObject var storage: Storage
    @StateObject var model: MainScreenViewModel
    @State var showError = false
    @State var lastError: String?
    @State var activity: Activity<FormulaAttributes>?
    
    var body: some View {
        NavigationView {
            ScrollView {
                Button(action: {
                    if activity != nil {
                        updateActivity()
                    } else {
                        activity = startActivity()                        
                    }
                }, label: {
                    Text("Start Activity")
                })
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

private extension MainScreenView {
    func startActivity() -> Activity<FormulaAttributes>? {
        var activity: Activity<FormulaAttributes>?
        let attributes = FormulaAttributes(lastPlaceDriver: "Nicholas Latifi")
        
        do {
            let contentState = FormulaAttributes.ContentState(
                driverInFront: "Max Verstappen",
                driverTeam: "Red Bull racing"
            )
            activity = try Activity<FormulaAttributes>.request(attributes: attributes, contentState: contentState)
        } catch {
            print(error.localizedDescription)
        }
        
        return activity
    }
    
    func updateActivity() {
        Task {
            let contentState = FormulaAttributes.ContentState(
                driverInFront: "not Lewis Hamilton",
                driverTeam: "Mercedes"
            )
            await activity?.update(using: contentState)
        }
    }
    
    func endActivity() {
        Task {
            for activity in Activity<FormulaAttributes>.activities {
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
}

#Preview {
    let apiProvider = APIProvider<RecipesEndpoint>()
    let model = MainScreenViewModel(apiProvider: apiProvider)
    model.setTestData()
    let view = MainScreenView(model: model).environmentObject(Storage())
    return view
}
