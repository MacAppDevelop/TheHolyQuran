//
//  GoToPopover.swift
//  Quran
//
//  Created by No one on 4/4/23.
//

import SwiftUI

struct GoToPopover: View {
    @ObservedObject private var surahVM = SurahVM.shared
        
    @State private var showPopover = false
    
    @State private var surahNumber: Int64?
    @State private var ayaNumber: Int64?
    
    @State private var invalidInput: Bool = false
    
    var body: some View {
        Button {
            showPopover.toggle()
            
            if showPopover, let surah = surahVM.surah {
                surahNumber = surah.surah_number
            }
        } label: {
            Image(systemName: "arrow.uturn.down")
        }
        .popover(isPresented: $showPopover, arrowEdge: .bottom) {
            VStack {
                Text("Go To:")
                
                TextField("Surah", value: $surahNumber.limitNumber(min: 1, max: 114), format: .number).frame(minWidth: 120)
                TextField("Aya", value: $ayaNumber.limitNumber(min: 0, max: 286), format: .number).frame(minWidth: 120)
                
                Button("Go") {
                    if let surahNumber, let ayaNumber {
                        if surahVM.goTo(surahNumber: surahNumber, ayaNumber: ayaNumber) {
                            invalidInput = false
                            showPopover = false
                        } else {
                            invalidInput = true
                        }
                    }
                }
                .keyboardShortcut(.return, modifiers: [])
                
                if invalidInput {
                    Text("Invalid Input").font(.footnote).foregroundColor(.red)
                }
                
                iPhoneDismissButton($showPopover)
            }
            .padding()
            .frame(minWidth: 140, minHeight: 170)
        }
        .onChange(of: ayaNumber) { newValue in
            if newValue ?? 0 <= 286 {
                invalidInput = false
            }
        }
    }
}

struct GoToPopover_Previews: PreviewProvider {
    static var previews: some View {
        GoToPopover()
    }
}
