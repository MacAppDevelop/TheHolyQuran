//
//  TranslationSettingsPopover.swift
//  Quran
//
//  Created by No one on 4/3/23.
//

import SwiftUI

struct TranslationSettingsPopover: View {
    @State private var showPopover = false
    @AppStorage(K.StorageKeys.selectedTranslationSQLiteFileName) private var selectedTranslationSQLiteFileName: String = K.defaultTranslationSQLiteFileName
    
    @State private var translatorName: String = ""
    
    var body: some View {
        Button {
            showPopover.toggle()
        } label: {
            Image(systemName: "globe.europe.africa.fill")
        }
        .popover(isPresented: $showPopover, arrowEdge: .bottom) {
            VStack {
                Text("Translation Language")
                
                Picker("", selection: $selectedTranslationSQLiteFileName) {
                    let noTranslation = IncludedTranslation.disableTranslation
                    Section("No Translation") {
                        Text("Disable Translation \(noTranslation.name)").tag(noTranslation.sqliteFile)
                    }
                    ForEach(TranslationLanguages.allCases) { lang in
                        Section("\(lang.rawValue) - \(lang.localName)") {
                            ForEach(K.includedTranslations.filter({ $0.language == lang.rawValue })) { translation in
                                Text(translation.name).tag(translation.sqliteFile)
                            }
                        }
                    }
                    Section("No Translation") {
                        Text("Disable Translation \(noTranslation.name)").tag(noTranslation.sqliteFile)
                    }
                }
                
                Text("Translator: \(IncludedTranslation(sqliteFileName: selectedTranslationSQLiteFileName).translator)").font(.footnote).lineLimit(2)
                
                iPhoneDismissButton($showPopover)
            }
            .padding()
            .frame(minWidth: 300)
        }
    }
    
}

struct TranslationSettingsPopover_Previews: PreviewProvider {
    static var previews: some View {
        TranslationSettingsPopover()
    }
}
