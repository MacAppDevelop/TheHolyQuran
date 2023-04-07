//
//  iPhoneDismissButton.swift
//  TheHolyQuran
//
//  Created by No one on 4/5/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func iPhoneDismissButton(_ isPresentingPopover: Binding<Bool>) -> some View {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            Button("Dismiss") {
                isPresentingPopover.wrappedValue = false
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        } else {
            EmptyView()
        }
        #else
        EmptyView()
        #endif
    }
}
