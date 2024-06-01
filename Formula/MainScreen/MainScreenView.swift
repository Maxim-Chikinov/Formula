//
//  MainScreenView.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI

struct MainScreenView: View {
    @State var counter: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Count \(counter)")
            
            Button(action: {
                counter += 1
            }, label: {
                Text("Increment")
            })
        }
    }
}

#Preview {
    MainScreenView()
}
