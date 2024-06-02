//
//  FeedbackManager.swift
//  Formula
//
//  Created by Chikinov Maxim on 02.06.2024.
//

import UIKit

enum FeedbackManager {
    static func mediumFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
}
