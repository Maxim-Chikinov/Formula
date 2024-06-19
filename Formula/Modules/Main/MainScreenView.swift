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
    @State var scrollOffset = CGPoint()
    @State var pullProgress: CGFloat = 0
    @State var isRefresh = false
    
    var body: some View {
        NavigationView {
            OffsetObservingScrollView(offset: $scrollOffset) {
                InfiniteProgressView()
                    .opacity(pullProgress)
                    .padding()
                    .frame(width: max(60 * pullProgress, 0),
                           height: max(60 * pullProgress, 0))
                RecipesList(
                    model: model,
                    onScrolledAtBottom: {
                        onScrolledAtBottom()
                    },
                    isLoading: model.state.recipesList.isEmpty
                )
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 60, trailing: 0))
                .frame(minWidth: 300, minHeight: 500)
            }
            .background(storage.theame == 0 ? Color.white : Color.black.opacity(0.9))
            .navigationTitle("Recipes List")
            .navigationBarItems(
                trailing: Button(action: {
                    if activity != nil {
                        updateActivity()
                    } else {
                        activity = startActivity()
                    }
                }, label: {
                    Text("Start Activity")
                })
            )
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
        .onChange(of: scrollOffset) { newValue in
            if isRefresh {
                pullProgress = 1
                return
            } else {
                pullProgress = -newValue.y / 150
            }
            
            // Check to refresh
            if pullProgress > 1 && !isRefresh {
                isRefresh = true
                FeedbackManager.mediumFeedback()
                Task {
                    try await model.refresh()
                    isRefresh = false
                    pullProgress = 0
                }
            }
        }
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

// MARK: - Activity View
private extension MainScreenView {
    func startActivity() -> Activity<FormulaAttributes>? {
        var activity: Activity<FormulaAttributes>?
        let attributes = FormulaAttributes(lastPlaceDriver: "Nicholas Latifi")
        
        do {
            let contentState = FormulaAttributes.ContentState(
                driverInFront: "Max Verstappen",
                driverTeam: "Red Bull racing"
            )
            activity = try Activity<FormulaAttributes>.request(
                attributes: attributes,
                contentState: contentState
            )
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
                if #available(iOS 16.2, *) {
                    await activity.end(nil, dismissalPolicy: .immediate)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}

#Preview {
    let apiProvider = APIProvider<RecipesEndpoint>()
    let model = TestMainScreenViewModel(apiProvider: apiProvider)
    let view = MainScreenView(model: model).environmentObject(Storage())
    return view
}
