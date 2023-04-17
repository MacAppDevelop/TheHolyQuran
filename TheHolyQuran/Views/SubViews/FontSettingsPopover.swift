//
//  FontSettingsPopover.swift
//  Quran
//
//  Created by No one on 4/3/23.
//

import SwiftUI

struct FontSettingsPopover: View {
    @State private var showPopover = false
    
    @AppStorage(K.StorageKeys.quranTextTypeSelection) private var quranTextTypeSelection: QuranTextType = .tanzilSimple
    
    @AppStorage(K.StorageKeys.selectedTranslationSQLiteFileName) private var selectedTranslationSQLiteFileName: String = K.defaultTranslationSQLiteFileName
    
    @AppStorage(K.StorageKeys.arabicFontFamily) private var arabicFontFamily: ArabicFonts = .defaultFontFamily
    @AppStorage(K.StorageKeys.arabicFontSize) private var arabicFontSize: Double = ArabicFonts.defaultFontSize
    
    @AppStorage(K.StorageKeys.translationFontFamily) private var translationFontFamily: TranslationFonts = .defaultFontFamily
    @AppStorage(K.StorageKeys.translationFontSize) private var translationFontSize: Double = TranslationFonts.defaultFontSize
    
    var body: some View {
        Button {
            showPopover.toggle()
        } label: {
            Image(systemName: "textformat.size")
        }
        .popover(isPresented: $showPopover, arrowEdge: .bottom) {
            VStack {
                Picker("Quran Text Type", selection: $quranTextTypeSelection) {
                    ForEach(QuranTextType.allCases) { textType in
                        Text("\(textType.rawValue)").tag(textType)
                    }
                }
                .padding(.top)
                Text("Source: \(quranTextTypeSelection.source)").font(.footnote)
                
                Picker("Arabic Font", selection: $arabicFontFamily) {
                    ForEach(ArabicFonts.available) { font in
                        Text(font.rawValue).tag(font)
                    }
                }
                .padding(.top)
                if let source = arabicFontFamily.source {
                    Text("Source: \(source)").font(.footnote)
                }
                
                Slider(value: $arabicFontSize, in: K.ayaFontMinSize...K.ayaFontMaxSize) {
                    Text("Arabic Font Size")
                } minimumValueLabel: {
                    Text("\(Int(K.ayaFontMinSize))")
                } maximumValueLabel: {
                    Text("\(Int(K.ayaFontMaxSize))")
                }
                
                Divider().padding(.vertical)
                
                if IncludedTranslation(sqliteFileName: selectedTranslationSQLiteFileName).notDisabled == true {
                    Picker("Translation Font", selection: $translationFontFamily) {
                        ForEach(TranslationFonts.available) { font in
                            Text(font.rawValue).tag(font)
                        }
                    }
                    
                    Slider(value: $translationFontSize, in: K.translationFontMinSize...K.translationFontMaxSize) {
                        Text("Translation Font Size")
                    } minimumValueLabel: {
                        Text("\(Int(K.translationFontMinSize))")
                    } maximumValueLabel: {
                        Text("\(Int(K.translationFontMaxSize))")
                    }
                    
                    Divider().padding(.vertical)
                } else {
                    VStack {
                        Text("You can change translation font here too")
                        Text("once you enable translations.")
                    }
                    .font(.footnote)
                    .padding(.bottom)
                }
                
                Button("Reset") {
                    arabicFontFamily = .defaultFontFamily
                    arabicFontSize = ArabicFonts.defaultFontSize
                    
                    translationFontFamily = .defaultFontFamily
                    translationFontSize = TranslationFonts.defaultFontSize
                }
                
                iPhoneDismissButton($showPopover)
            }
            .padding()
            .frame(minWidth: 300)
        }
    }
}

struct FontSettings_Previews: PreviewProvider {
    static var previews: some View {
        FontSettingsPopover()
    }
}
