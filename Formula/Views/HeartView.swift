//
//  HeartView.swift
//  Formula
//
//  Created by Chikinov Maxim on 18.06.2024.
//

import SwiftUI

struct HeartView: View {
    @Binding var isSelect: Bool
    var onTapSelect: ((Bool) -> ())
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(isSelect ? Color(.systemGray5) : .red)
            Image(systemName: "heart.fill")
                .resizable()
                .foregroundColor(isSelect ? .red : .white)
                .scaledToFill()
                .padding(2)
                .scaleEffect(isSelect ? 0.6 : 0.4)
            
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3)) {
                isSelect.toggle()
            }
            onTapSelect(isSelect)
        }
    }
}

#Preview {
    HeartView(isSelect: .constant(true), onTapSelect: { _ in }).frame(width: 40, height: 40)
}
