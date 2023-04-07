//
//  NavToolbarContent.swift
//  Quran
//
//  Created by No one on 4/1/23.
//

import SwiftUI

struct NavToolbarContent: ToolbarContent {
    @AppStorage(K.StorageKeys.savedStateSurah) private var savedStateSurah: Int = 0
    @AppStorage(K.StorageKeys.savedStateAya) private var savedStateAya: Int = 0
    
    var body: some ToolbarContent {
        #if os(macOS)
        let placement: ToolbarItemPlacement = .primaryAction
        #else
        let placement: ToolbarItemPlacement = .status
        #endif
        
        ToolbarItemGroup(placement: placement) {
            FontSettingsPopover()
            
            TranslationSettingsPopover()
            
            GoToPopover()
            
            if savedStateSurah != 0 {
                Button {
                    _ = SurahVM.shared.goTo(surahNumber: Int64(savedStateSurah), ayaNumber: Int64(savedStateAya))
                    #if DEBUG
                    print("Loading State - Surah: \(savedStateSurah), Aya: \(savedStateAya)")
                    #endif
                } label: {
                    Label("Load Saved State", systemImage: "signpost.left.fill")
                }
                .help("Load Saved State")
            }

//            Button {
//                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
//            } label: {
//                Image(systemName: "gear")
//            }
        }
    }
}
