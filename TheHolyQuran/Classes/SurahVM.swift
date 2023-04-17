//
//  SurahVM.swift
//  Quran
//
//  Created by No one on 4/4/23.
//

import SwiftUI

class SurahVM: ObservableObject {
    static let shared = SurahVM()
    
    @Published private(set) var surah: SurahDBTable? = nil
    @Published private(set) var ayats: [AyaDBTable]? = nil
    @Published private(set) var translations: [TranslationDBTable]? = nil
    @Published private(set) var includedTranslation: IncludedTranslation!
    
    @Published private(set) var scrollToAyaID: AyaDBTable.ID? = nil
    @Published var startScrolling: Bool = false
    
    @AppStorage(K.StorageKeys.selectedTranslationSQLiteFileName) private var selectedTranslationSQLiteFileName: String = K.defaultTranslationSQLiteFileName
    
    init() {
        if selectedTranslationSQLiteFileName == "" {
            includedTranslation = IncludedTranslation.disableTranslation
        } else {
            includedTranslation = IncludedTranslation(sqliteFileName: selectedTranslationSQLiteFileName)
        }
    }
    
    private var db = DatabaseHandler.shared
    
    func setSelectedSurah(surahNumber: Int64) {
        if let getSurah = db.surahs.first(where: { $0.surah_number == surahNumber }),
           let getAyats = db.fetchSurahContent(surahNumber)
        {
            DispatchQueue.main.async {
                self.surah = getSurah
                self.ayats = getAyats
                
                if self.includedTranslation.notDisabled {
                    self.translations = self.db.fetchTranslationForSurah(surahNumber: surahNumber, translation: self.includedTranslation)
                }
            }
        }
    }
    
    func unset() {
        surah = nil
        ayats = nil
        translations = nil
        scrollToAyaID = nil
        startScrolling = false
    }
    
    func setIncludedTranslation(fileName: String) {
        if fileName == "" {
            includedTranslation = IncludedTranslation.disableTranslation
        } else {
            includedTranslation = IncludedTranslation(sqliteFileName: fileName)
        }
    }
    
    func updateTranslations(surahNumber: Int64, translationSQLiteFile: String) {
        if selectedTranslationSQLiteFileName == "" {
            includedTranslation = IncludedTranslation.disableTranslation
            translations = nil
        } else {
            includedTranslation = IncludedTranslation(sqliteFileName: selectedTranslationSQLiteFileName)
            translations = db.fetchTranslationForSurah(surahNumber: surahNumber, translation: includedTranslation)
        }
    }
    
    func goTo(surahNumber: Int64, ayaNumber: Int64) -> Bool {
        // Check
        guard db.ayaExist(surahNumber: surahNumber, ayaNumber: ayaNumber) else {
            return false
        }
        
        scrollToAyaID = AyaDBTable.generateIDFrom(surahNumber: surahNumber, ayaNumber: ayaNumber)
        setSelectedSurah(surahNumber: surahNumber)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.startScrolling = true
        }
        
        return true
    }
}
