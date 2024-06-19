//
//  InfiniteProgressView.swift
//  Formula
//
//  Created by Chikinov Maxim on 18.06.2024.
//

import SwiftUI

struct InfiniteProgressView: View {
    @State private var isRotate = false
    @State private var isTrim = false
    
    var body: some View {
        GeometryReader(content: { geometry in
            Circle()
                .trim(from: 0.0, to: isTrim ? 0.7 : 0.1)
                .stroke(Color.blue, lineWidth: geometry.size.width / 10)
                .rotationEffect(.degrees(isRotate ? 360 : 0))
                .scaleEffect(CGSize(width: isRotate ? 0.5 : 1.0, height: isRotate ? 0.5 : 1.0))
                .onAppear(perform: {
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        isRotate = true
                        isTrim = true
                    }
                })
            
            Circle()
                .trim(from: 0.0, to: isTrim ? 0.5 : 0)
                .stroke(Color.green, lineWidth: geometry.size.width / 10)
                .rotationEffect(.degrees(isRotate ? 360 : 0))
                .scaleEffect(CGSize(width: isRotate ? 0.7 : 1.0, height: isRotate ? 0.7 : 1.0))
                .onAppear(perform: {
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        isRotate = true
                        isTrim = true
                    }
                })
            
            Circle()
                .trim(from: 0.0, to: isTrim ? 0.6 : 0)
                .stroke(Color.red, lineWidth: geometry.size.width / 10)
                .rotationEffect(.degrees(isRotate ? 300 : 0))
                .onAppear(perform: {
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        isRotate = true
                        isTrim = true
                    }
                })
        })
        
    }
}

#Preview {
    InfiniteProgressView()
        .frame(width: 100, height: 100)
}
