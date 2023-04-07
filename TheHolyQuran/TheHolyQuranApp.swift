//
//  TheHolyQuranApp.swift
//  TheHolyQuran
//
//  Created by No one on 4/5/23.
//

import SwiftUI

@main
struct TheHolyQuranApp: App {
    @AppStorage(K.StorageKeys.appearance) private var appearance: Theme = .system
    @StateObject private var db = DatabaseHandler.shared
    
    var body: some Scene {
        #if os(macOS)
        Window("Quran", id: "Quran-App") {
            MainView()
                .environmentObject(db)
                .preferredColorScheme(appearance.colorScheme)
                .frame(minWidth: 900, minHeight: 550)
        }
        
        Settings {
            SettingsView()
                .preferredColorScheme(appearance.colorScheme)
                .frame(minWidth: 500, minHeight: 400)
        }
        #else
        WindowGroup {
            MainView()
                .environmentObject(db)
                .preferredColorScheme(appearance.colorScheme)
        }
        #endif
    }
}
