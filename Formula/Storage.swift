//
//  Storage.swift
//  Formula
//
//  Created by Chikinov Maxim on 02.06.2024.
//

import SwiftUI

class Storage: ObservableObject {
    @AppStorage("ApplicationTheam") var theame: Int = 0
}
