//
//  FormulaApp.swift
//  Formula
//
//  Created by Chikinov Maxim on 31.05.2024.
//

import SwiftUI

@main
struct FormulaApp: App {
    var body: some Scene {
        WindowGroup {
            let storage = Storage()
            TabBarScreenView().environmentObject(storage)
        }
    }
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.purple, .font: UIFont(name: "PingFang SC Regular", size: 35) ?? UIFont()]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.purple, .font: UIFont(name: "PingFang SC Regular", size: 20) ?? UIFont()]
        
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.purple, .font: UIFont(name: "PingFang SC Regular", size: 14) ?? UIFont()]
        navBarAppearance.buttonAppearance = buttonAppearance
        
        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.uturn.left"), transitionMaskImage: UIImage(systemName: "arrow.uturn.left"))
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
}

#Preview(body: {
    TabBarScreenView().environmentObject(Storage())
})
