//
//  MaciPadNavBackButtonToolbar.swift
//  TheHolyQuran
//
//  Created by No one on 4/5/23.
//

import SwiftUI

struct MaciPadNavBackButtonToolbar: ViewModifier {
    @Binding var selectedSurah: SurahDBTable?
    @ObservedObject private var surahVM = SurahVM.shared
    
    @ViewBuilder
    func body(content: Content) -> some View {
        #if os(macOS)
        content.toolbar {
            toolbarContent
        }
        #else
        if UIDevice.current.userInterfaceIdiom == .pad {
            content.toolbar {
                toolbarContent
            }
        } else {
            content
        }
        #endif
    }
    
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigation) {
            Button {
                selectedSurah = nil
                surahVM.unset()
            } label: {
                Label("", systemImage: "chevron.left")
            }
        }
    }
}

extension View {
    func maciPadNavBackButtonToolbar(selectedSurah: Binding<SurahDBTable?>) -> some View {
        self.modifier(MaciPadNavBackButtonToolbar(selectedSurah: selectedSurah))
    }
}
