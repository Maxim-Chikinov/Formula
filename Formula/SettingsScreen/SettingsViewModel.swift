//
//  SettingsViewModel.swift
//  Formula
//
//  Created by Chikinov Maxim on 02.06.2024.
//

import SwiftUI
import MessageUI

class SettingsViewModel: ObservableObject {
    @Published var showingBugEmail = false
    @Published var showingFeatureEmail = false
    @Published var showMailBugAlert = false
    @Published var showMailFeatureAlert = false
    @Published var showShareSheet = false
    @Published var showCreditsView = false
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
}
