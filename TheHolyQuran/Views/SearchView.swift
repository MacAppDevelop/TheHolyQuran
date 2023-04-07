//
//  SearchView.swift
//  TheHolyQuran
//
//  Created by No one on 4/5/23.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchQuery: String
    @ObservedObject private var surahVM = SurahVM.shared
    @EnvironmentObject private var db: DatabaseHandler
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage(K.StorageKeys.arabicFontFamily) private var arabicFontFamily: ArabicFonts = .defaultFontFamily
    @AppStorage(K.StorageKeys.arabicFontSize) private var arabicFontSize: Double = ArabicFonts.defaultFontSize
    
    @AppStorage(K.StorageKeys.translationFontFamily) private var translationFontFamily: TranslationFonts = .defaultFontFamily
    @AppStorage(K.StorageKeys.translationFontSize) private var translationFontSize: Double = TranslationFonts.defaultFontSize
    
    @AppStorage(K.StorageKeys.selectedTranslationSQLiteFileName) private var selectedTranslationSQLiteFileName: String = K.defaultTranslationSQLiteFileName
    
    @State private var foundAyats: [AyaDBTable] = []
    @State private var foundTranslations: [TranslationDBTable] = []
    
    @State private var timer: Timer? = nil
    @State private var isSearchingAyats: Bool = false
    @State private var isSearchingTranslations: Bool = false
    
    @State private var isGoingToAya: Bool = false
    
    @State private var selectedIncludedTranslation: IncludedTranslation? = nil
    
    var body: some View {
        bodyContent
        .onAppear {
            selectedIncludedTranslation = IncludedTranslation(sqliteFileName: selectedTranslationSQLiteFileName)
            searchWithTimer()
        }
        .onChange(of: searchQuery) { _ in
            searchWithTimer()
        }
    }
    
    @ViewBuilder
    var bodyContent: some View {
        let bgColor = (colorScheme == .dark) ? Color.black.opacity(0.2) : Color.white
        
        if isSearchingAyats || isSearchingTranslations || isGoingToAya {
            VStack {
                if !isGoingToAya {
                    Text("Searching: \(searchQuery)")
                }
                ProgressView()
            }
        } else {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    resultTitle("Result in Ayats (\(foundAyats.count)):")
                    
                    ForEach(foundAyats) { aya in
                        HStack {
                            Text(aya.text)
                                .font(Font.custom(arabicFontFamily.rawValue, size: arabicFontSize))
                                .textSelection(.enabled)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .conditional(aya.sajda) { v in
                                    v.foregroundColor(.red)
                                }
                            
                            Spacer()
                            
                            if aya.sajda {
                                Label("السجدة", systemImage: "person.fill.turn.right").labelStyle(.titleAndIcon)
                            }
                            
                            if aya.aya_id > 0 {
                                AyaInfo(aya: aya)
                            }
                            
                            goToButton(surahNumber: aya.surah_id, ayaNumber: aya.aya_id)

                        }
                        Divider()
                    }
                    .environment(\.locale, .init(identifier: "ar"))
                    .environment(\.layoutDirection, .rightToLeft)
                    
                    showTotalCount(foundAyats.count)
                    
                    Divider()
                    
                    if let selectedIncludedTranslation {
                        resultTitle("Result in Selected Translation (\(foundTranslations.count)):")
                        
                        ForEach(foundTranslations) { t in
                            HStack {
                                Text(t.text)
                                    .font(Font.custom(translationFontFamily.rawValue, size: translationFontSize))
                                    .textSelection(.enabled)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(8)
                                    .lineSpacing(K.translationLineSpacing)
                                
                                Spacer()
                                
                                goToButton(surahNumber: t.sura, ayaNumber: t.aya)
                            }
                        }
                        .environment(\.locale, selectedIncludedTranslation.locale)
                        .environment(\.layoutDirection, selectedIncludedTranslation.direction)
                        
                        showTotalCount(foundTranslations.count)
                    }
                }
                .padding()
                .background(bgColor)
                .cornerRadius(15)
                .padding(.bottom)
            }
            .padding(.horizontal)
        }
    }
    
    func goToButton(surahNumber: Int64, ayaNumber: Int64) -> some View {
        Button {
            isGoingToAya = true
            surahVM.unset()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                _ = surahVM.goTo(surahNumber: surahNumber, ayaNumber: ayaNumber)
            }
        } label: {
            Label("Go", systemImage: "arrow.left.square.fill").labelStyle(.iconOnly).font(.largeTitle)
        }
        .buttonStyle(.borderless)
    }
    
    func resultTitle(_ text: String) -> some View {
        return Text(text).font(.headline).frame(maxWidth: .infinity).padding().background(.thickMaterial).cornerRadius(5).bold()
    }
    
    func showTotalCount(_ count: Int) -> some View {
        Text("Total: \(count)").padding().background(.thickMaterial).cornerRadius(5).bold().padding(.top)
    }
    
    func searchWithTimer() {
        guard searchQuery.count >= K.minimumMainSearchCharacters else { return }
        
        timer?.invalidate()
        isSearchingAyats = true
        if selectedIncludedTranslation != nil {
            isSearchingTranslations = true
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            DispatchQueue.global(qos: .userInitiated).async {
                // Search in Ayats
                let ayatsSearchResults = db.searchInAyats(searchQuery)
                DispatchQueue.main.async {
                    isSearchingAyats = false
                    foundAyats = ayatsSearchResults
                }
                
                if let selectedIncludedTranslation {
                    // Search in Translations
                    let translationsSearchResults = db.searchInTranslation(searchQuery, translationSQLiteFile: selectedIncludedTranslation.sqliteFile)
                    DispatchQueue.main.async {
                        isSearchingTranslations = false
                        foundTranslations = translationsSearchResults
                    }
                }
            }
        }
    }
}

