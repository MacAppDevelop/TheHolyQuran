//
//  InterfaceLanguages.swift
//  Quran
//
//  Created by No one on 4/4/23.
//

import SwiftUI

enum InterfaceLanguages: String, CaseIterable, Identifiable, Codable {
    case arabic = "ar"
    case english = "en"
    case turkish = "tr"
    case persian = "fa"
    case urdu = "ur"
    case pashto = "ps"
    
    var id: String {
        self.rawValue
    }
    
    var direction: LayoutDirection {
        switch self {
        case .arabic, .persian, .urdu, .pashto:
            return .rightToLeft
        default:
            return .leftToRight
        }
    }
    
    var locale: Locale {
        .init(identifier: self.rawValue)
    }
    
    var description: String {
        switch self {
        case .arabic:
            return "العربية"
        case .turkish:
            return "Türkçe"
        case .persian:
            return "فارسی"
        case .urdu:
            return "اردو"
        case .pashto:
            return "پښتو"
        default:
            return String(describing: self).capitalized
        }
    }
    
    static var defaultInterfaceLanguage: InterfaceLanguages {
        return .english
    }
}
