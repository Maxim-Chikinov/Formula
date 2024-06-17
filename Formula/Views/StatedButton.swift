//
//  StatedButton.swift
//  Formula
//
//  Created by Chikinov Maxim on 17.06.2024.
//

import SwiftUI

struct StatedButton<Label>: View where Label: View {
    @State private var buttonStyle: SelectableButtonStyle
    private let action: ((_ isSelected: Bool) -> ())?
    private let label: (() -> Label)?

    init(
        isSelected: Bool,
        action: ((_ isSelected: Bool) -> ())? = nil,
        label: (() -> Label)? = nil
    ) {
        self.action = action
        self.label = label
        self.buttonStyle = SelectableButtonStyle(isSelected: isSelected)
    }

    var body: some View {
        Button(action: {
            buttonStyle.isSelected.toggle()
            action?(buttonStyle.isSelected)
        }) {
            label?()
        }
        .buttonStyle(buttonStyle)
    }
}

struct SelectableButtonStyle: ButtonStyle {

    var isSelected: Bool
    
    init(isSelected: Bool) {
        self.isSelected = isSelected
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.bouncy, value: configuration.isPressed)
            .animation(.linear, value: isSelected)
            .foregroundStyle(isSelected ? Color.yellow: Color.gray)
            .background(
                Rectangle()
                    .fill(configuration.isPressed ? Color.white.opacity(0.4) : Color.white)
                    .cornerRadius(6)
            )
    }
}

#Preview {
    @State var isFavourite: Bool = false
    
    return StatedButton(
        isSelected: false,
        action: { isSelected in 
            isFavourite.toggle()
        }, label: {
            Text("★")
        })
    .padding(4)
    .background {
        Color.gray
    }
}
