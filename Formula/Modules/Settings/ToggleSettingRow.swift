//
//  ToggleSettingRow.swift
//  Formula
//
//  Created by Chikinov Maxim on 02.06.2024.
//

import SwiftUI

struct ToggleSettingRow: View {
    var imageName: String
    var title: String
    var action: ((Int) -> ())
    @Binding var selection: Int

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: imageName)
                .font(.headline)
                .foregroundColor(.purple)
                .frame(minWidth: 25, alignment: .leading)
                .accessibility(hidden: true)
            Text(title)
                .kerning(1)
            Spacer()
            Picker("Color", selection: $selection) {
                Text("Light").tag(0)
                Text("Dark").tag(1)
            }
            .pickerStyle(.segmented)
            .onChange(of: selection) { newValue in
                action(newValue)
            }
        }
        .padding(.vertical, 10)
        .foregroundColor(.primary)
        .customHoverEffect()
    }
}

#Preview {
    ToggleSettingRow(
        imageName: "paintpalette",
        title: "Appearence",
        action: {_ in },
        selection: .constant(1)
    )
    .frame(width: 300, height: 40)
    .settingsBackground()
}

