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
}

#Preview(body: {
    TabBarScreenView()
})
