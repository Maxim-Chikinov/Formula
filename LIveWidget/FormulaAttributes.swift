//
//  FormulaAttributes.swift
//  Formula
//
//  Created by Chikinov Maxim on 07.06.2024.
//

import SwiftUI
import ActivityKit

struct FormulaAttributes: ActivityAttributes {
    public typealias RaceState = ContentState
    
    // Здесь вы предоставляете динамические данные
    public struct ContentState: Codable, Hashable {
        var driverInFront: String
        var driverTeam: String
    }
    
    // А здесь вы предоставляете статические данные
    var lastPlaceDriver: String
}

extension FormulaAttributes {
    static var preview: FormulaAttributes {
        FormulaAttributes(lastPlaceDriver: "Preview last driver")
    }
}

extension FormulaAttributes.ContentState {
    static var one: FormulaAttributes.ContentState {
        FormulaAttributes.ContentState(driverInFront: "DriverInFront of 1", driverTeam: "maclaren")
    }
    
    static var two: FormulaAttributes.ContentState {
        FormulaAttributes.ContentState(driverInFront: "DriverInFront of 2", driverTeam: "maclaren")
    }
}
