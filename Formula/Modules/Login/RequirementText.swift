//
//  RequirementText.swift
//  Formula
//
//  Created by Chikinov Maxim on 20.06.2024.
//

import SwiftUI

struct RequirementText: View {
    var iconName = "xmark.square"
    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)
    var text = ""
    var isStrikeThrough = false

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
                .strikethrough(isStrikeThrough)
            Spacer()
        }
    }
}

#Preview {
    RequirementText(
        iconName: "pencil.circle", 
        iconColor: Color.gray,
        text: "Text of requirement",
        isStrikeThrough: true
    )
}
