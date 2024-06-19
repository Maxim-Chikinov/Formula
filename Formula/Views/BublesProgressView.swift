//
//  BublesProgressView.swift
//  Formula
//
//  Created by Chikinov Maxim on 18.06.2024.
//

import SwiftUI

struct BublesProgressView: View {
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            HStack {
                ForEach(0...10, id: \.self) { index in
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(isLoading ? .green : .gray)
                        .scaleEffect(isLoading ? 1 : 0.3)
                        .rotationEffect(.degrees(isLoading ? 0 : 180), anchor: .bottomTrailing)
                        .animation(
                            .linear(duration: 0.6).repeatForever().delay(0.2 * Double(index)), value: isLoading
                        )
                }
            }
            .onAppear() {
                isLoading = true
            }
        }
    }
}

#Preview {
    BublesProgressView()
}
