//
//  Tab.swift
//  Formula
//
//  Created by Chikinov Maxim on 31.05.2024.
//

import SwiftUI

enum Tab: Int, CaseIterable {
    case main
    case search
    case news
    case profile
    case settings
    
    var text: String {
        switch self {
        case .main:
            return "main"
        case .search:
            return "search"
        case .news:
            return "news"
        case .profile:
            return "profile"
        case .settings:
            return "settings"
        }
    }
    
    var imageName: String {
        switch self {
        case .main:
            return "house.fill"
        case .search:
            return "doc.text.magnifyingglass"
        case .news:
            return "newspaper.fill"
        case .profile:
            return "person.fill"
        case .settings:
            return "gearshape"
        }
    }
    
    var color: Color {
        switch self {
        case .main:
            return Color(hex: "9AB998")
        case .search:
            return Color(hex: "FEBE89")
        case .news:
            return Color(hex: "F4837D")
        case .profile:
            return Color(hex: "EA4960")
        case .settings:
            return Color(hex: "29363C")
        }
    }
}
