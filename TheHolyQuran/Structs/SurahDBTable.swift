//
//  SurahDBTable.swift
//  Quran
//
//  Created by No one on 4/2/23.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif
import GRDB

struct SurahDBTable: Codable, FetchableRecord, PersistableRecord, Hashable, Identifiable, Equatable {
    var surah_number: Int64
    var name: String
    var name_english: String
    var place: Int64
    
    var placeName: String {
        if place == 1 {
            return "المكيّة"
        } else {
            return "المدنيّة"
        }
    }
    
    var placeNameSimple: String {
        if place == 1 {
            return "مكية"
        } else {
            return "مدنية"
        }
    }
    
    var id: Int64 {
        surah_number
    }
    
    var nameWithoutDiacritics: String {
        let mStringRef = NSMutableString(string: name) as CFMutableString
        CFStringTransform(mStringRef, nil, kCFStringTransformStripCombiningMarks, false)
        return mStringRef as String
    }
    
    var name_persian: String {
        return nameWithoutDiacritics
            .replacingOccurrences(of: "ي", with: "ی")
            .replacingOccurrences(of: "ة", with: "ه")
            .replacingOccurrences(of: "ال", with: "")
    }
    
    func existsInSearch(_ text: String) -> Bool {
        return (
            name.contains(text) ||
            name_english.lowercased().contains(text.lowercased()) ||
            existsInEnglishWithVariations(text) ||
            (Int(text) ?? 0 > 0 && Int(surah_number) == Int(text)) ||
            placeName.contains(text) ||
            placeNameSimple.contains(text) ||
            nameWithoutDiacritics.contains(text) ||
            name_persian.contains(text)
        )
    }
    
    func existsInEnglishWithVariations(_ text: String) -> Bool {
        return (
            name_english.lowercased().replacingOccurrences(of: "-", with: " ").contains(text.lowercased()) ||
            name_english.lowercased().replacingOccurrences(of: "q", with: "gh").contains(text.lowercased()) ||
            name_english.lowercased().replacingOccurrences(of: "q", with: "k").contains(text.lowercased()) ||
            name_english.lowercased().replacingOccurrences(of: "k", with: "q").contains(text.lowercased()) ||
            name_english.lowercased().replacingOccurrences(of: "u", with: "o").contains(text.lowercased()) ||
            name_english.lowercased().replacingOccurrences(of: "w", with: "v").contains(text.lowercased())
        )
    }
    
    static func ==(lhs: SurahDBTable, rhs: SurahDBTable) -> Bool {
        return lhs.surah_number == rhs.surah_number
    }
}
