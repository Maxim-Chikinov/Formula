//
//  MainScreenComponent.swift
//  Formula
//
//  Created by Chikinov Maxim on 13.06.2024.
//

import SwiftUI
import NeedleFoundation

final class RootComponent: BootstrapComponent {
    
    private let searchRecipesProvider = APIProvider<RecipesEndpoint>()
    
    var rootViewController: some View {
        let model = MainScreenViewModel(apiProvider: searchRecipesProvider)
        return MainScreenView(model: model)
    }
}
