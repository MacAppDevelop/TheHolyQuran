//
//  AyaDBTable.swift
//  Quran
//
//  Created by No one on 4/1/23.
//

import GRDB

struct AyaDBTable: Codable, FetchableRecord, PersistableRecord, Hashable, Identifiable, Equatable {
    var surah_id: Int64
    var aya_id: Int64
    var page: Int64
    var quarter: Int64
    var hizb: Int64
    var juz: Int64
    var sajda: Bool
    var text: String
    var uthmanitext: String
    var searchtext: String
    var quarterstart: Bool
    
    var id: String {
        AyaDBTable.generateIDFrom(surahNumber: surah_id, ayaNumber: aya_id)
    }
    
    static func generateIDFrom(surahNumber: Int64, ayaNumber: Int64) -> String {
        return "\(surahNumber),\(ayaNumber)"
    }
    
    static func ==(lhs: AyaDBTable, rhs: AyaDBTable) -> Bool {
        return lhs.id == rhs.id
    }
}
