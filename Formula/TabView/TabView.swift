//
//  TabBar.swift
//  Formula
//
//  Created by Chikinov Maxim on 31.05.2024.
//

import SwiftUI

struct TabBarView: View {
    var tabbarItems: [String]
    
    @Binding var selectedIndex: Int
    @Namespace private var menuItemTransition
    
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tabbarItems.indices, id: \.self) { index in
                        TabbarItem(
                            name: tabbarItems[index],
                            isActive: selectedIndex == index,
                            namespace: menuItemTransition
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selectedIndex = index
                            }
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(25)
            .onChange(of: selectedIndex) { index in
                withAnimation {
                    scrollView.scrollTo(index, anchor: .center)
                }
            }
        }
        
    }
}

#Preview {
    let tabs = ["One", "Two", "Three", "Four", "Five", "Six"]
    return TabBarView(tabbarItems: tabs, selectedIndex: .constant(2)).padding()
}
