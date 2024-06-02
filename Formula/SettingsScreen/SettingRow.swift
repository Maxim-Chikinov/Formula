//
//  SettingRow.swift
//  Formula
//
//  Created by Chikinov Maxim on 02.06.2024.
//

import SwiftUI

struct SettingsRow: View {
    var imageName: String
    var title: String
    var action: (()->()) = {}

    var body: some View {
        Button(action: {
            self.action()
            FeedbackManager.mediumFeedback()
        }) {
            HStack(spacing: 8) {
                Image(systemName: imageName)
                    .font(.headline)
                    .foregroundColor(.purple)
                    .frame(minWidth: 25, alignment: .leading)
                    .accessibility(hidden: true)
                Text(title)
                    .kerning(1)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(.vertical, 10)
            .foregroundColor(.primary)
        }
        .customHoverEffect()
    }
}

#Preview {
    SettingsRow(imageName: "wand.and.stars", title: "Feature request")
        .frame(width: 300, height: 40)
        .settingsBackground()
}
