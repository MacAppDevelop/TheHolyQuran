//
//  SurahView.swift
//  Quran
//
//  Created by No one on 4/1/23.
//

import SwiftUI
import GRDB

struct SurahView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage(K.StorageKeys.selectedTranslationSQLiteFileName) private var selectedTranslationSQLiteFileName: String = K.defaultTranslationSQLiteFileName
    
    @AppStorage(K.StorageKeys.arabicFontFamily) private var arabicFontFamily: ArabicFonts = .defaultFontFamily
    @AppStorage(K.StorageKeys.arabicFontSize) private var arabicFontSize: Double = ArabicFonts.defaultFontSize
    
    @AppStorage(K.StorageKeys.translationFontFamily) private var translationFontFamily: TranslationFonts = .defaultFontFamily
    @AppStorage(K.StorageKeys.translationFontSize) private var translationFontSize: Double = TranslationFonts.defaultFontSize
    
    @AppStorage(K.StorageKeys.savedStateSurah) private var savedStateSurah: Int = 0
    @AppStorage(K.StorageKeys.savedStateAya) private var savedStateAya: Int = 0
    @State private var savedAyaID: AyaDBTable.ID? = nil
    
    @EnvironmentObject private var surahVM: SurahVM
    
    @State private var inViewArabicFontFamily: ArabicFonts? = nil
    @State private var inViewArabicFontSize: Double? = nil
    @State private var inViewTranslationFontFamily: TranslationFonts? = nil
    @State private var inViewTranslationFontSize: Double? = nil
    
    private var fontsChanged: [String] {[
        arabicFontFamily.rawValue,
        String(arabicFontSize),
        translationFontFamily.rawValue,
        String(translationFontSize)
    ]}
    
    @State private var timer: Timer? = nil
    
    var body: some View {
        if let surah = surahVM.surah, let ayats = surahVM.ayats {
            displaySurah(surah: surah, ayats: ayats)
                .onChange(of: fontsChanged) { _ in // Without this fonts won't change instantly
                    inViewArabicFontFamily = arabicFontFamily
                    inViewArabicFontSize = arabicFontSize
                    inViewTranslationFontFamily = translationFontFamily
                    inViewTranslationFontSize = translationFontSize
                }
            
        } else {
            Text("Something went wrong, please report this issue to us.")
            Text("Error Description: SurahView#01")
        }
    }
    
    @ViewBuilder
    func displaySurah(surah: SurahDBTable, ayats: [AyaDBTable]) -> some View {
        let bgColor = (colorScheme == .dark) ? Color.black.opacity(0.2) : Color.white
        
        ScrollViewReader { scrollViewProxy in
            ScrollView(.vertical) {
                let surahName = "سورة" + " " + surah.name
                #if os(macOS)
                surahNameBordered(surahName, bgColor: bgColor)
                #else
                if UIDevice.current.userInterfaceIdiom == .pad {
                    surahNameBordered(surahName, bgColor: bgColor)
                } else {
                    surahNameNoBorder(surahName)
                }
                #endif
                
                
                LazyVStack(alignment: .leading, spacing: K.surahSpacing) {
                    ForEach(ayats) { aya in
                        VStack {
                            HStack {
                                Text(aya.text)
                                    .font(Font.custom(inViewArabicFontFamily?.rawValue ?? arabicFontFamily.rawValue, size: inViewArabicFontSize ?? arabicFontSize))
                                    .lineSpacing(K.surahSpacing)
                                    .textSelection(.enabled)
                                    .conditional(aya.sajda) { v in
                                        v.foregroundColor(.red)
                                    }
                                
                                Spacer()
                                
                                if aya.sajda {
                                    Label("السجدة", systemImage: "person.fill.turn.right").labelStyle(.titleAndIcon)
                                }
                                
                                saveStateButton(for: aya)
                                
                                if aya.aya_id > 0 {
                                    AyaInfo(aya: aya)
                                    verseNumber(aya.aya_id)
                                }
                            }
                            .id(aya.id)
                            .conditional(aya == ayats.first) { v in
                                v.padding(.top, K.surahSpacing / 2)
                            }
                            
                            if surahVM.includedTranslation.notDisabled, let translation = surahVM.translations?.first(where: { $0.aya == aya.aya_id }) {
                                HStack {
                                    Text(translation.text)
                                        .font(Font.custom(inViewTranslationFontFamily?.rawValue ?? translationFontFamily.rawValue, size: inViewTranslationFontSize ?? translationFontSize))
                                        .textSelection(.enabled)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 6)
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(8)
                                        .lineSpacing(K.translationLineSpacing)
                                    Spacer()
                                }
                                .environment(\.locale, surahVM.includedTranslation.locale)
                                .environment(\.layoutDirection, surahVM.includedTranslation.direction)
                            }
                        }
                        
                        if aya != ayats.last {
                            Divider()
                        }
                    }
                }
                .padding()
                .background(bgColor)
                .cornerRadius(15)
                .padding(.bottom)
                .onChange(of: surahVM.startScrolling) { scroll in
                    if scroll, let scrollPosition = surahVM.scrollToAyaID {
                        withAnimation {
                            scrollViewProxy.scrollTo(scrollPosition, anchor: .center)
                        }
                        
                        surahVM.startScrolling = false
                    }
                }
            }
        }
        .onChange(of: selectedTranslationSQLiteFileName) { _ in
            surahVM.updateTranslations(surahNumber: surah.surah_id, translationSQLiteFile: selectedTranslationSQLiteFileName)
        }
    }
    
    @ViewBuilder
    func saveStateButton(for aya: AyaDBTable) -> some View {
        let isSaved = (savedAyaID == aya.id || (aya.aya_id == savedStateAya && aya.surah_id == savedStateSurah))
        Button {
            if isSaved {
                savedStateSurah = 0
                savedStateAya = 0
                savedAyaID = nil
            } else {
                savedStateSurah = Int(aya.surah_id)
                savedStateAya = Int(aya.aya_id)
                savedAyaID = aya.id
                #if DEBUG
                print("Saved State - Surah: \(savedStateSurah), Aya: \(savedStateAya)")
                #endif
            }
        } label: {
            Label(isSaved ? "Unsave" : "Save", systemImage: isSaved ? "signpost.right.fill" : "signpost.right")
                .labelStyle(.iconOnly)
                .foregroundColor(isSaved ? .green : .black)
        }
        .buttonStyle(.borderless)
        .help(isSaved ? "Unsave" : "Save Here to Reload Later")
    }
    
    func surahNameBordered(_ surahName: String, bgColor: Color) -> some View {
        // Surah Border Image Source: https://en.wikipedia.org/wiki/File:Sura_border.svg
        Image("SurahNameBorder").resizable().scaledToFit().frame(maxWidth: 550).overlay {
            Text(surahName)
                .font(Font.custom(K.surahNameFontFamily.rawValue, size: K.surahNameFontSize))
                .textSelection(.enabled)
                .foregroundColor(Color(red: 0.6, green: 0.45, blue: 0.24, opacity: 1.0))
        }
        .background(bgColor)
        .padding()
    }
    
    func surahNameNoBorder(_ surahName: String) -> some View {
        Text(surahName)
            .font(Font.custom(K.surahNameFontFamily.rawValue, size: K.surahNameFontSize))
            .foregroundColor(Color(red: 0.6, green: 0.45, blue: 0.24, opacity: 1.0))
    }
    
    func verseNumber(_ number: Int64) -> some View {
        // Image Source: https://pixabay.com/vectors/separator-verse-koran-number-36415/
        Image("VerseNumberBackground").resizable().scaledToFit().frame(width: K.verseNumberSize, height: K.verseNumberSize).overlay {
            Text("\(number)").font(.title3).bold().foregroundColor(.primary)
        }
    }
}
