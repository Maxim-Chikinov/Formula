//
//  Tab.swift
//  Formula
//
//  Created by Chikinov Maxim on 31.05.2024.
//

import Foundation

enum Tab: Int, CaseIterable {
    case one
    case two
    case three
    case four
    case five
    
    var text: String {
        switch self {
        case .one:
            return "One"
        case .two:
            return "Two"
        case .three:
            return "Three"
        case .four:
            return "Four"
        case .five:
            return "Five"
        }
    }
}
