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
    
    @AppStorage(K.StorageKeys.quranTextTypeSelection) private var quranTextTypeSelection: QuranTextType = .tanzilSimple
    
    @AppStorage(K.StorageKeys.selectedTranslationSQLiteFileName) private var selectedTranslationSQLiteFileName: String = K.defaultTranslationSQLiteFileName
    
    @AppStorage(K.StorageKeys.arabicFontFamily) private var arabicFontFamily: ArabicFonts = .defaultFontFamily
    @AppStorage(K.StorageKeys.arabicFontSize) private var arabicFontSize: Double = ArabicFonts.defaultFontSize
    
    @AppStorage(K.StorageKeys.translationFontFamily) private var translationFontFamily: TranslationFonts = .defaultFontFamily
    @AppStorage(K.StorageKeys.translationFontSize) private var translationFontSize: Double = TranslationFonts.defaultFontSize
    
    @AppStorage(K.StorageKeys.savedStateSurah) private var savedStateSurah: Int = 0
    @AppStorage(K.StorageKeys.savedStateAya) private var savedStateAya: Int = 0
    @State private var savedAyaID: AyaDBTable.ID? = nil
    
    @EnvironmentObject private var surahVM: SurahVM
    
    @State private var inViewQuranTextType: QuranTextType? = nil
    @State private var inViewArabicFontFamily: ArabicFonts? = nil
    @State private var inViewArabicFontSize: Double? = nil
    @State private var inViewTranslationFontFamily: TranslationFonts? = nil
    @State private var inViewTranslationFontSize: Double? = nil
    
    private var fontsChanged: [String] {[
        quranTextTypeSelection.rawValue,
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
                    inViewQuranTextType = quranTextTypeSelection
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
                                Text(aya.getText(inViewQuranTextType ?? quranTextTypeSelection))
                                    .font(Font.custom(inViewArabicFontFamily?.rawValue ?? arabicFontFamily.rawValue, size: inViewArabicFontSize ?? arabicFontSize))
                                    .lineSpacing(K.surahSpacing)
                                    .conditional(aya.sajda) { v in
                                        v.foregroundColor(aya.sajdaObligatory ? .red : .orange)
                                    }
                                
                                Spacer()
                                
                                if aya.sajda {
                                    let alSajda = "السجدة"
                                    let alSajdaObligatory = "السجدة الواجبة"
                                    Label(aya.sajdaObligatory ? alSajdaObligatory : alSajda, systemImage: "person.fill.turn.right").labelStyle(.titleAndIcon)
                                }
                                
                                saveStateButton(for: aya)
                                
                                if aya.aya_number > 0 {
                                    AyaInfo(aya: aya)
                                    verseNumber(aya.aya_number)
                                }
                            }
                            .id(aya.id)
                            .conditional(aya == ayats.first) { v in
                                v.padding(.top, K.surahSpacing / 2)
                            }
                            
                            if surahVM.includedTranslation.notDisabled, let translation = surahVM.translations?.first(where: { $0.aya == aya.aya_number }) {
                                HStack {
                                    Text(translation.text)
                                        .font(Font.custom(inViewTranslationFontFamily?.rawValue ?? translationFontFamily.rawValue, size: inViewTranslationFontSize ?? translationFontSize))
                                        .foregroundColor(.primary)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 6)
                                        .background(colorScheme == .dark ? .ultraThickMaterial : .ultraThinMaterial)
                                        .cornerRadius(8)
                                        .lineSpacing(K.translationLineSpacing)
                                    Spacer()
                                }
                                .environment(\.locale, surahVM.includedTranslation.locale)
                                .environment(\.layoutDirection, surahVM.includedTranslation.direction)
                            }
                        }
                        .textSelection(.enabled)
                        
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
            surahVM.updateTranslations(surahNumber: surah.surah_number, translationSQLiteFile: selectedTranslationSQLiteFileName)
        }
        .onAppear {
            if savedStateAya != 0 && savedStateSurah != 0 {
                savedAyaID = AyaDBTable.generateIDFrom(surahNumber: Int64(savedStateSurah), ayaNumber: Int64(savedStateAya))
            }
        }
    }
    
    @ViewBuilder
    func saveStateButton(for aya: AyaDBTable) -> some View {
        let isSaved = (savedAyaID == aya.id || (aya.aya_number == savedStateAya && aya.surah_number == savedStateSurah))
        Button {
            if isSaved {
                savedStateSurah = 0
                savedStateAya = 0
                savedAyaID = nil
            } else {
                savedStateSurah = Int(aya.surah_number)
                savedStateAya = Int(aya.aya_number)
                savedAyaID = aya.id
                #if DEBUG
                print("Saved State - Surah: \(savedStateSurah), Aya: \(savedStateAya)")
                #endif
            }
        } label: {
            Label(isSaved ? "Unsave" : "Save", systemImage: isSaved ? "signpost.right.fill" : "signpost.right")
                .labelStyle(.iconOnly)
                .foregroundColor(isSaved ? .green : .primary)
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
