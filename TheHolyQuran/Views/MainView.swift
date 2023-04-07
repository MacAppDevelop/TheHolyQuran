//
//  MainView.swift
//  Quran
//
//  Created by No one on 4/1/23.
//

import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var db: DatabaseHandler
    
    @State private var mainSearchQuery = ""
    
    @StateObject private var surahVM = SurahVM.shared
    
    @State private var selectedSurah: SurahDBTable?
    
    @State private var showSurahSearch = false
    @State private var surahSearchText = ""
    @FocusState private var focusSurahSearchField: Bool?
    
    @AppStorage(K.StorageKeys.selectedTranslationSQLiteFileName) private var selectedTranslationSQLiteFileName: String = K.defaultTranslationSQLiteFileName
    
    @State private var showBookmarkedOnly = false
    @AppStorage(K.StorageKeys.bookmarkedSurahs) private var bookmarkedSurahs: [String] = []

    var body: some View {
        NavigationSplitView {
            VStack {
                HStack {
                    Text("Surah")
                    Spacer()
                    
                    Button {
                        withAnimation {
                            showBookmarkedOnly.toggle()
                        }
                    } label: {
                        Label("List Bookmarked", systemImage: showBookmarkedOnly ? "bookmark.fill" : "bookmark").labelStyle(.iconOnly)
                    }
                    
                    Button {
                        showSurahSearch.toggle() // withAnimation causes crash!
                        
                        if showSurahSearch {
                            focusSurahSearchField = true
                        } else {
                            focusSurahSearchField = false
                            surahSearchText = ""
                        }
                    } label: {
                        Label("Search...", systemImage: showSurahSearch ? "text.magnifyingglass" : "magnifyingglass").labelStyle(.iconOnly)
                    }
                    
                    Text("سورة")
                }
                .bold()
                .padding(.horizontal)
                
                if showSurahSearch {
                    TextField("Filter Surahs List...", text: $surahSearchText)
                        .textFieldStyle(.roundedBorder)
                        .background(colorScheme == .dark ? .clear : .white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .focused($focusSurahSearchField, equals: true)
                        .multilineTextAlignment(.center)
                }
                
                List(selection: $selectedSurah) {
                    if surahsResults.isEmpty {
                        Text("No Surahs Found.").font(.footnote).bold()
                    }
                    
                    ForEach(surahsResults) { surah in
                        NavigationLink(value: surah) {
                            HStack {
                                Text("\(surah.surah_id)").font(.footnote).foregroundColor(.secondary)
                                Text(surah.name_english)
                                Spacer()
                                Text(surah.name)
                                
                                if bookmarkedSurahs.contains(String(surah.surah_id)) {
                                    Image(systemName: "bookmark.fill")
                                }
                            }
                        }
                        .contextMenu {
                            if bookmarkedSurahs.contains(String(surah.surah_id)) {
                                Button {
                                    bookmarkedSurahs.removeAll(where: { $0 == String(surah.surah_id) })
                                } label: {
                                    Label("Unbookmark", systemImage: "bookmark.slash").labelStyle(.titleAndIcon)
                                }
                            } else {
                                Button {
                                    bookmarkedSurahs.append(String(surah.surah_id))
                                } label: {
                                    Label("Bookmark", systemImage: "bookmark").labelStyle(.titleAndIcon)
                                }
                            }
                        }
                    }
                    
                    if showBookmarkedOnly {
                        VStack(alignment: .leading) {
                            Text("\(showSurahSearch ? "Searching" : "Listing") only bookmarked Surahs")
                            
                            if bookmarkedSurahs.count == 0 {
                                Text("Right click on a Surah to bookmark it.").padding(.top, 5)
                            }
                        }
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .bold()
                    }
                }
                .listStyle(.sidebar)
            }
            #if os(macOS)
            .navigationSplitViewColumnWidth(min: 220, ideal: 230, max: 300)
            #else
            .navigationSplitViewColumnWidth(min: 240, ideal: 280, max: 300)
            #endif
        } detail: {
            if selectedSurah != nil || (surahVM.surah != nil && surahVM.scrollToAyaID != nil) {
                SurahView()
                    .environmentObject(surahVM)
                    .environment(\.locale, .init(identifier: "ar"))
                    .environment(\.layoutDirection, .rightToLeft)
                    .padding(.horizontal)
                    .maciPadNavBackButtonToolbar(selectedSurah: $selectedSurah)
                    #if os(macOS)
                    .navigationTitle(surahVM.surah?.name ?? K.mainAppNavigationTitle)
                    #endif
            } else {
                Group {
                    if mainSearchQuery.count >= K.minimumMainSearchCharacters {
                        SearchView(searchQuery: $mainSearchQuery)
                            .navigationTitle("Searching: \(mainSearchQuery)")
                    } else {
                        WelcomeView()
                            .navigationTitle(K.mainAppNavigationTitle)
                    }
                }
                .searchable(text: $mainSearchQuery, prompt: "Search (minimum \(K.minimumMainSearchCharacters) characters)...")
            }
        }
        .toolbar {
            NavToolbarContent()
        }
        .onChange(of: selectedSurah?.surah_id ?? 0) { newValue in
            surahVM.setSelectedSurah(surahNumber: newValue)
        }
        .onChange(of: selectedTranslationSQLiteFileName) { newValue in
            surahVM.setIncludedTranslation(fileName: newValue)
        }
        .onChange(of: mainSearchQuery) { newValue in
            let searchSurah = db.surahs.filter { $0.existsInSearch(mainSearchQuery) }
            if searchSurah.count > 0 {
                showSurahSearch = true
                surahSearchText = newValue
            } else {
                showSurahSearch = false
                surahSearchText = ""
            }
        }
        .alert(db.alert.message, isPresented: $db.alert.show) {
            Button("OK"){}
        }
    }
    
    var surahsResults: [SurahDBTable] {
        if showBookmarkedOnly && !surahSearchText.isEmpty {
            return db.surahs.filter { bookmarkedSurahs.contains(String($0.surah_id)) && $0.existsInSearch(surahSearchText) }
        } else if showBookmarkedOnly {
            return db.surahs.filter { bookmarkedSurahs.contains(String($0.surah_id)) }
        } else if !surahSearchText.isEmpty {
            return db.surahs.filter { $0.existsInSearch(surahSearchText) }
        } else {
            return db.surahs
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
