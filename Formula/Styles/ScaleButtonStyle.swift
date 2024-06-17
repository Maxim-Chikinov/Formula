//
//  ScaleButtonStyle.swift
//  Formula
//
//  Created by Chikinov Maxim on 16.06.2024.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.bouncy, value: configuration.isPressed)
    }
}
