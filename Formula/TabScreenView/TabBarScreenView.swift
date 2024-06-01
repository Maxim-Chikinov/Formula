//
//  TabBarView.swift
//  Formula
//
//  Created by Chikinov Maxim on 31.05.2024.
//

import SwiftUI

struct TabBarScreenView: View {
    @State var selectedIndex: Int = 0
    
    var currentTab: Tab {
        Tab(rawValue: selectedIndex) ?? .main
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Screens
            TabView(selection: $selectedIndex, content: {
                MainScreenView(model: MainViewModel())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .tag(Tab.main.rawValue)
                SearchScreenView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .tag(Tab.search.rawValue)
                NewsScreenView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .tag(Tab.news.rawValue)
                ProfileScreenView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .tag(Tab.profile.rawValue)
                SettingsScreenView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .tag(Tab.settings.rawValue)
            })
            
            // TabBar
            let tabs = Tab.allCases.map({ TabBarItemVieModel(tab: $0)})
            TabBarView(tabBarItems: tabs, selectedIndex: $selectedIndex)
                .padding(.horizontal)
        }
    }
    
    init() {
        UITabBar.appearance().isHidden = true
    }
}

#Preview {
    TabBarScreenView()
}
