//
//  TabBar.swift
//  Formula
//
//  Created by Chikinov Maxim on 31.05.2024.
//

import SwiftUI

struct TabBarView: View {
    var tabBarItems: [TabBarItemVieModel]
    
    @Binding var selectedIndex: Int
    @Namespace private var menuItemTransition
    
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tabBarItems.indices, id: \.self) { index in
                        TabBarItem(
                            model: tabBarItems[index],
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
                .padding(10)
            }
            .background(Color(.systemGray6))
            .cornerRadius(25)
            .onChange(of: selectedIndex) { newValue in
                withAnimation {
                    scrollView.scrollTo(newValue, anchor: .center)
                }
            }
        }
    }
}

#Preview {
    let tabs = Tab.allCases.map({ TabBarItemVieModel(tab: $0)})
    return TabBarView(tabBarItems: tabs, selectedIndex: .constant(2)).padding()
}
