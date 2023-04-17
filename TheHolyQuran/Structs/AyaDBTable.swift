//
//  AyaDBTable.swift
//  Quran
//
//  Created by No one on 4/1/23.
//

import GRDB

// TheHolyQuran.sqlite: A mix of different text types and metadata from https://tanzil.net and https://quran.islam-db.com/data/

struct AyaDBTable: Codable, FetchableRecord, PersistableRecord, Hashable, Identifiable, Equatable {
    var surah_number: Int64
    var aya_number: Int64
    var page: Int64
    var quarter: Int64
    var hizb: Int64
    var juz: Int64
    var quarterstart: Bool
    
    var text_islamdb: String
    var searchtext_islamdb: String
    
    var text_tanzil_simple: String
    var text_tanzil_simple_plain: String
    var text_tanzil_simple_min: String
    var text_tanzil_simple_clean: String
    var text_tanzil_uthmani: String
    var text_tanzil_uthmani_min: String
    
    var sajda: Bool {
        QuranMetadata.sajdas.contains(where: { $0.surahNumber == surah_number && $0.ayaNumber == aya_number })
    }
    
    var sajdaObligatory: Bool {
        QuranMetadata.sajdas.contains(where: { $0.surahNumber == surah_number && $0.ayaNumber == aya_number && $0.obligatory == true })
    }
    
    var id: String {
        AyaDBTable.generateIDFrom(surahNumber: surah_number, ayaNumber: aya_number)
    }
    
    func getText(_ textType: QuranTextType) -> String {
        switch textType {
        case .islamDB:
            return text_islamdb
        case .tanzilSimple:
            return text_tanzil_simple
        case .tanzilSimplePlain:
            return text_tanzil_simple_plain
        case .tanzilSimpleMin:
            return text_tanzil_simple_min
        case .tanzilSimpleClean:
            return text_tanzil_simple_clean
        case .tanzilUthmani:
            return text_tanzil_uthmani
        case .tanzilUthmaniMin:
            return text_tanzil_uthmani_min
        }
    }
    
    static func generateIDFrom(surahNumber: Int64, ayaNumber: Int64) -> String {
        return "\(surahNumber),\(ayaNumber)"
    }
    
    static func ==(lhs: AyaDBTable, rhs: AyaDBTable) -> Bool {
        return lhs.id == rhs.id
    }
}


