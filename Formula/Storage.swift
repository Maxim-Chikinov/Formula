//
//  Storage.swift
//  Formula
//
//  Created by Chikinov Maxim on 02.06.2024.
//

import SwiftUI
import Combine

class Storage: ObservableObject {
    @AppStorage("ApplicationTheam") var theame: Int = 0
    @AppStorage("view.preferences.showFavouriteOnly") var showFavouriteOnly: Bool = false
    @AppStorage("view.preferences.displayOrder") var displayOrder: Int = 0
    @AppStorage("view.preferences.maxCaloriesLevel") var maxCaloriesLevel: Int = 0
    
    var displayOrderType: DisplayOrderType {
        DisplayOrderType(type: displayOrder)
    }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
