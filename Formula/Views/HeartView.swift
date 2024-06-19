//
//  HeartView.swift
//  Formula
//
//  Created by Chikinov Maxim on 18.06.2024.
//

import SwiftUI

struct HeartView: View {
    @State private var circleColorChanged: Bool
    @State private var heartColorChanged: Bool
    @State private var heartSizeChanged: Bool
    @State private var opacity: Double = 1
    var onTap: (() -> ())
    
    init(isSelect: Bool, onTap: @escaping (() -> ())) {
        self.circleColorChanged = isSelect
        self.heartColorChanged = isSelect
        self.heartSizeChanged = isSelect
        self.onTap = onTap
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(circleColorChanged ? Color(.systemGray5) : .red)
            Image(systemName: "heart.fill")
                .resizable()
                .foregroundColor(heartColorChanged ? .red : .white)
                .scaledToFill()
                .padding(2)
                .scaleEffect(heartSizeChanged ? 0.6 : 0.4)
            
        }
        .opacity(opacity)
        .animation(.easeInOut, value: opacity)
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3)) {
                circleColorChanged.toggle()
                heartColorChanged.toggle()
                heartSizeChanged.toggle()
            }
            onTap()
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    opacity = 0.5
                })
                .onEnded({ value in
                    opacity = 1
                })
        )
    }
}

#Preview {
    HeartView(isSelect: true, onTap: {}).frame(width: 40, height: 40)
}
