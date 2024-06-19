//
//  CustomNavigationBarModifier.swift
//  Formula
//
//  Created by Chikinov Maxim on 19.06.2024.
//

import SwiftUI

extension View {
    func setNavigationBar(title: String) -> some View {
        modifier(CustomNavigationBar(title: title))
    }
}

struct CustomNavigationBar: ViewModifier {
    @Environment(\.dismiss) var dismiss
    let title: String
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
            .navigationBarBackButtonHidden()
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.backward.square")
                            Text("Back")
                        }
                        .foregroundColor(.indigo)
                    })
                }
            })
    }
}

#Preview {
    NavigationStack {
        SearchScreenView().setNavigationBar(title: "Search screen")
    }
}
