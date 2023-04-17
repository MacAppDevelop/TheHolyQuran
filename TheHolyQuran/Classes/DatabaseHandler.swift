
//
//  DatabaseHandler.swift
//  Quran
//
//  Created by No one on 4/1/23.
//

import SwiftUI
import GRDB

class DatabaseHandler: ObservableObject {
    static let shared = DatabaseHandler()
    
    @Published var alert: (show: Bool, message: String) = (false, "")
    @Published var surahs: [SurahDBTable] = []
    
    var configuration = Configuration()
    
    private var theHolyQuran: DatabaseQueue!
    
    init() {
        // DBConfigurations
        configuration.readonly = true
        
        do {
            theHolyQuran = try DatabaseQueue(path: sqlitePath(K.theHolyQuranArabicSQLiteFile), configuration: configuration)
        } catch {
            fatalError("Failed to find \(K.theHolyQuranArabicSQLiteFile).sqlite in the project bundle.")
        }
        
        if let fetchedSurahs = fetchSurahsList() {
            surahs = fetchedSurahs
        }
    }
    
    private func sqlitePath(_ resourceName: String) throws -> String {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "sqlite") else {
            throw URLError(.fileDoesNotExist)
        }
        
        return path
    }
    
    func fetchSurahsList() -> [SurahDBTable]? {
        do {
            return try theHolyQuran.read { db in
                try SurahDBTable
                    .order(Column("surah_number"))
                    .fetchAll(db)
            }
        } catch {
            showError(error.localizedDescription)
            return nil
        }
    }
    
    func fetchSurahContent(_ number: Int64) -> [AyaDBTable]? {
        do {
            return try theHolyQuran.read { db in
                try AyaDBTable
                    .filter(Column("surah_number") == number)
                    .order(Column("aya_number"))
                    .fetchAll(db)
            }
        } catch {
            showError(error.localizedDescription)
            return nil
        }
    }
    
    func ayaExist(surahNumber: Int64, ayaNumber: Int64) -> Bool {
        if let _ = try? theHolyQuran.read({ db in
            try AyaDBTable
                .filter(Column("surah_number") == surahNumber)
                .filter(Column("aya_number") == ayaNumber)
                .fetchOne(db)
        }) {
            return true
        } else {
            return false
        }
    }
    
    func fetchTranslationForSurah(surahNumber: Int64, translation: IncludedTranslation) -> [TranslationDBTable]? {
        do {
            let translationDBQueue = try DatabaseQueue(path: sqlitePath(translation.sqliteFile), configuration: configuration)
            return try translationDBQueue.read { db in
                try TranslationDBTable
                    .filter(Column("sura") == surahNumber)
                    .order(Column("aya"))
                    .fetchAll(db)
            }
        } catch {
            showError(error.localizedDescription)
            return nil
        }
    }
    
    private func showError(_ title: String) {
        DispatchQueue.main.async {
            self.alert = (true, title)
        }
    }
}

// MARK: - Search in Quran

extension DatabaseHandler {
    func searchInAyats(_ text: String) -> [AyaDBTable] {
        guard !text.isEmpty else {
            return []
        }
        
        var ayats: [AyaDBTable] = []
        
        do {
            let searchIslamDBSearchText = try theHolyQuran.read { db in
                try AyaDBTable
                    .filter(sql: "searchtext_islamdb LIKE ?", arguments: ["%\(text)%"])
                    .order([Column("surah_number"), Column("aya_number")])
                    .fetchAll(db)
            }
            
            searchIslamDBSearchText.forEach { aya in
                if !ayats.contains(aya) {
                    ayats.append(aya)
                }
            }
            
            let searchTanzilTextSimpleClean = try theHolyQuran.read { db in
                try AyaDBTable
                    .filter(sql: "text_tanzil_simple_clean LIKE ?", arguments: ["%\(text)%"])
                    .order([Column("surah_number"), Column("aya_number")])
                    .fetchAll(db)
            }
            
            searchTanzilTextSimpleClean.forEach { aya in
                if !ayats.contains(aya) {
                    ayats.append(aya)
                }
            }
            
            let searchTanzilTextSimpleMin = try theHolyQuran.read { db in
                try AyaDBTable
                    .filter(sql: "text_tanzil_simple_min LIKE ?", arguments: ["%\(text)%"])
                    .order([Column("surah_number"), Column("aya_number")])
                    .fetchAll(db)
            }
            
            searchTanzilTextSimpleMin.forEach { aya in
                if !ayats.contains(aya) {
                    ayats.append(aya)
                }
            }
        } catch {
            showError(error.localizedDescription)
        }
        
        return ayats
    }
    
    func searchInTranslation(_ text: String, translationSQLiteFile: String) -> [TranslationDBTable] {
        guard !translationSQLiteFile.isEmpty && !text.isEmpty else {
            return []
        }
        
        var translations: [TranslationDBTable] = []
        
        do {
            let translationDBQueue = try DatabaseQueue(path: sqlitePath(translationSQLiteFile))
            let searchText = try translationDBQueue.read { db in
                try TranslationDBTable
                    .filter(sql: "text LIKE ?", arguments: ["%\(text)%"])
                    .order([Column("sura"), Column("aya")])
                    .fetchAll(db)
            }
            
            searchText.forEach { t in
                translations.append(t)
            }
        } catch {
            showError(error.localizedDescription)
        }
        
        return translations
    }
}
