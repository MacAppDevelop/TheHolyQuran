//
//  Theme.swift
//  Quran
//
//  Created by No one on 4/1/23.
//

import SwiftUI

enum Theme: String, Codable, CaseIterable, Identifiable {
    case system = "System"
    case dark = "Dark Mode"
    case light = "Light Mode"
    
    var id: String {
        self.rawValue
    }
    
    var icon: String {
        switch self {
        case .dark:
            return "moon"
        case .light:
            return "sun.max"
        case .system:
            return "rays"
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .dark:
            return ColorScheme.dark
        case .light:
            return ColorScheme.light
        case .system:
            return .none
        }
    }
}
