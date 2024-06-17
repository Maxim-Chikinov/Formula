//
//  RecipeDetailView.swift
//  Formula
//
//  Created by Chikinov Maxim on 16.06.2024.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject var model: RecipeDetailViewModel
    
    var body: some View {
        Text("Detail")
    }
}

#Preview {
    let model = RecipeDetailViewModel()
    return RecipeDetailView(model: model)
}
