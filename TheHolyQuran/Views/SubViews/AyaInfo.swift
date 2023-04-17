//
//  AyaInfo.swift
//  Quran
//
//  Created by No one on 4/2/23.
//

import SwiftUI

struct AyaInfo: View {
    @State private var showPopover = false
    let aya: AyaDBTable
    
    var body: some View {
        Image(systemName: "info.bubble").frame(width: K.surahSpacing / 2, height: K.surahSpacing / 2).onHover { hovering in
            showPopover = hovering
        }
        .popover(isPresented: $showPopover) {
            VStack(alignment: .leading) {
                Text("Surah Number: \(aya.surah_number)")
                Text("Aya Number: \(aya.aya_number)")
                Text("Page: \(aya.page)")
                Text("Quarter: \(aya.quarter)")
                Text("Hizb (Group): \(aya.hizb)")
                Text("Juz (Part): \(aya.juz)")
                Text("Sajda (Islamic Prostration): \(aya.sajda ? "Yes\(aya.sajdaObligatory ? " (Obligatory)" : "" )" : "No")")
            }
            .padding()
            .font(.footnote)
        }
    }
}
