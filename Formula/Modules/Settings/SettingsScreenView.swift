//
//  SettingsScreenView.swift
//  Formula
//
//  Created by Chikinov Maxim on 01.06.2024.
//

import SwiftUI
import MessageUI

struct SettingsScreenView: View {
    @EnvironmentObject var storage: Storage
    @ObservedObject var model = SettingsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                AboutView(title: "💜 the application? share!", accessibilityTitle: "Love the application? share!")
                
                VStack {
                    ToggleSettingRow(
                        imageName: "paintpalette",
                        title: "Appearance",
                        action: { value in
                            storage.theame = value
                        },
                        selection: $storage.theame
                    )
                    
                    SettingsRow(imageName: "square.and.arrow.up", title: "Share") {
                        self.model.showShareSheet = true
                    }
                    .sheet(isPresented: $model.showShareSheet) {
                        ShareSheetView(activityItems: ["Can you beat me in Gradient Game?"])
                            .edgesIgnoringSafeArea(.bottom)
                    }
                    
                    SettingsRow(imageName: "pencil.and.outline", title: "Write a review") {
                        
                    }

                    SettingsRow(imageName: "textbox", title: "Tweet about it") {
                        
                    }
                }
                .settingsBackground()

                VStack {
                    SettingsRow(imageName: "wand.and.stars", title: "Feature request") {
                        
                    }
                    .alert(isPresented: $model.showMailFeatureAlert) {
                        Alert(
                            title: Text("No Mail Accounts"),
                            message: Text("Please set up a Mail account in order to send email"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .sheet(isPresented: $model.showingFeatureEmail) {
                        
                    }
                    
                    SettingsRow(imageName: "tornado", title: "Report a bug") {
                        
                    }
                    .alert(isPresented: self.$model.showMailBugAlert) {
                        Alert(
                            title: Text("No Mail Accounts"),
                            message: Text("Please set up a Mail account in order to send email"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .sheet(isPresented: $model.showingBugEmail) {
                        
                    }
                    
                    AppVersionRow(
                        imageName: "info.circle",
                        title: "App version",
                        version: model.appVersion
                    )
                }
                .settingsBackground()

                VStack {
                    SettingsRow(imageName: "textbox", title: "Creator") {
                        
                    }
                    
                    SettingsRow(imageName: "hand.thumbsup", title: "Credits", action: {
                        self.model.showCreditsView = true
                    })
                    .sheet(isPresented: $model.showCreditsView) {
                        CreditsView()
                    }
                }
                .settingsBackground()
                
                AboutView(
                    title: "MADE WITH ❤️ BY MAXIM CHIKINOV", 
                    accessibilityTitle: "MADE WITH LOVE BY MAXIM CHIKINOV"
                )
            }
            .navigationBarTitle("Settings")
            .background(storage.theame == 0 ? Color.white : Color.black.opacity(0.9))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SettingsScreenView().environmentObject(Storage())
}
