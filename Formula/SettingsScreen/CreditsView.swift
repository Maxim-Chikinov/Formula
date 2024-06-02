//
//  CreditsView.swift
//  Formula
//
//  Created by Chikinov Maxim on 02.06.2024.
//

import SwiftUI

struct CreditsView: View {
    var appURL: URL = URL(string: "https://apps.apple.com/us/app/neon-color-and-gradient-maker/id1480273650")!
    var body: some View {
        NavigationView {
            ScrollView {
                Text("The first version of the settings screen was inspired by my close friend's app.")
                    .kerning(0.2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .settingsBackground()

                SettingsRow(imageName: "eyedropper.halffull", title: "Text") {
                    UIApplication.shared.open(self.appURL)
                }
                .padding()
                .settingsBackground()
            }
            .navigationBarTitle("Credits")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
