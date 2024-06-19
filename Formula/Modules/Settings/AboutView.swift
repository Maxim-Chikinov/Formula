//
//  AboutView.swift
//  Formula
//
//  Created by Chikinov Maxim on 02.06.2024.
//

import SwiftUI

struct AboutView: View {
    var title: String
    var accessibilityTitle: String

    var body: some View {
        Text(title.uppercased())
            .foregroundColor(.secondary)
            .font(.caption)
            .kerning(1)
            .frame(minWidth: 100, maxWidth: .infinity, alignment: .center)
            .accessibility(label: Text(accessibilityTitle))
            .padding(.top)
    }
}

#Preview {
    AboutView(title: "💜 the game? share!", accessibilityTitle: "Love the game? share!")
}

