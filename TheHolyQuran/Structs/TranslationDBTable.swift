//
//  TranslationDBTable.swift
//  Quran
//
//  Created by No one on 4/4/23.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif
import GRDB

struct TranslationDBTable: Codable, FetchableRecord, PersistableRecord, Hashable, Identifiable, Equatable {
    var index: Int64
    var sura: Int64
    var aya: Int64
    var text: String
    
    var id: Int64 {
        index
    }
    
    static func ==(lhs: TranslationDBTable, rhs: TranslationDBTable) -> Bool {
        return lhs.id == rhs.id
    }
}
