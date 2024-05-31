//
//  ContentView.swift
//  Formula
//
//  Created by Chikinov Maxim on 31.05.2024.
//

import SwiftUI

struct ContentView: View {
    @State var selectedIndex: Int = 0
    
    var currentTab: Tab {
        Tab(rawValue: selectedIndex) ?? .one
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Text(currentTab.text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.1), value: selectedIndex)
            
            TabBarView(
                tabbarItems: Tab.allCases.map({ $0.text }),
                selectedIndex: $selectedIndex
            )
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}
