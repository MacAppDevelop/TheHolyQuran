//
//  AppFonts.swift
//  Quran
//
//  Created by No one on 4/3/23.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

protocol FontGroupEnum: CaseIterable, Identifiable, Codable {
    var id: String { get }
    var rawValue: String { get }
}

protocol AppFonts: FontGroupEnum {
    associatedtype FontCase: FontGroupEnum
}

extension AppFonts {
    var id: String {
        self.rawValue
    }
    
    static var available: [FontCase] {
        var availableFonts: [FontCase] = []
        
        #if os(macOS)
        for family in NSFontManager.shared.availableFontFamilies {
            if let font = includes(family) {
                availableFonts.append(font)
            }
        }
        #else
        let fontFamilyNames = UIFont.familyNames

        for family in fontFamilyNames {
            if let font = includes(family) {
                availableFonts.append(font)
            }
        }
        #endif
        
        return availableFonts
    }
    
    static func firstAvailable(from fonts: [FontCase], fallback: FontCase) -> FontCase {
        for font in fonts {
            if available.contains(where: { $0.id == font.id }) {
                return font
            }
        }
        
        return fallback
    }
    
    static func includes(_ font: String) -> FontCase? {
        for enumFont in FontCase.allCases {
            if enumFont.rawValue == font {
                return enumFont
            }
        }
        
        return nil
    }
}
