//
//  IncludedTranslation.swift
//  Quran
//
//  Created by No one on 4/2/23.
//

import SwiftUI

struct IncludedTranslation: Identifiable, Hashable {
    static let disableTranslation = IncludedTranslation(lang: "", langLocal: "", name: "", translator: "", sql: "", locId: "")
    
    init(sqliteFileName: String) {
        let findOrDisable = K.includedTranslations.first(where: { $0.sqliteFile == sqliteFileName }) ?? Self.disableTranslation
        
        language = findOrDisable.language
        languageLocalName = findOrDisable.languageLocalName
        name = findOrDisable.name
        translator = findOrDisable.translator
        sqliteFile = findOrDisable.sqliteFile
        locale = findOrDisable.locale
        direction = findOrDisable.direction
    }
    
    init(lang language: String, langLocal languageLocalName: String, name: String, translator: String, sql sqliteFile: String, locId localeIdentifier: String, dir direction: LayoutDirection = .leftToRight) {
        self.language = language
        self.languageLocalName = languageLocalName
        self.name = name
        self.translator = translator
        self.sqliteFile = sqliteFile
        self.locale = .init(identifier: localeIdentifier)
        self.direction = direction
    }
    
    let language: String
    let languageLocalName: String
    let name: String
    let translator: String
    let sqliteFile: String
    
    let locale: Locale
    let direction: LayoutDirection
    
    var id: String {
        sqliteFile
    }
    
    var fullName: String {
        "\(language) - \(languageLocalName) - \(name) - \(translator)"
    }
    
    var isDisabled: Bool {
        translator.count == 0 || sqliteFile.count == 0
    }
    
    var notDisabled: Bool {
        !isDisabled
    }
    
    func fetchSurahTranslationFromDB(surahNumber: Int64) -> [TranslationDBTable]? {
        guard notDisabled else { return nil }
        return DatabaseHandler.shared.fetchTranslationForSurah(surahNumber: surahNumber, translation: self)
    }
}
