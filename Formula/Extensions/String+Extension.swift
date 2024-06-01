//
//  String+Extension.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
