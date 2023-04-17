//
//  QuranTextType.swift
//  The Holy Quran
//
//  Created by No one on 4/15/23.
//

import Foundation

enum QuranTextType: String, CaseIterable, Identifiable {
    case tanzilSimple = "Simple"
    case tanzilSimplePlain = "Simple (Plain)"
    case tanzilSimpleMin = "Simple (Minimal)"
    case tanzilSimpleClean = "Clean (No diacritics or symbols)"
    case tanzilUthmani = "Uthmani"
    case tanzilUthmaniMin = "Uthmani (Minimal)"
    case islamDB = "Simple - Islam-DB"
    
    var id: String {
        self.rawValue
    }
    
    var source: String {
        switch self {
        case .islamDB:
            return "https://quran.islam-db.com/data/"
        default:
            return "https://tanzil.net/download/"
        }
    }
}
