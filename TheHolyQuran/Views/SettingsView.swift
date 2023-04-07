//
//  SettingsView.swift
//  Quran
//
//  Created by No one on 4/2/23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(K.StorageKeys.appearance) private var appearance: Theme = .system
    
    var body: some View {
        Form {
            Picker("Appearance", selection: $appearance) {
                ForEach(Theme.allCases) { theme in
                    Label(theme.rawValue, systemImage: theme.icon)
                        .labelStyle(.titleAndIcon)
                        .tag(theme)
                }
            }
            .pickerStyle(.segmented)
            
            Spacer()
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
