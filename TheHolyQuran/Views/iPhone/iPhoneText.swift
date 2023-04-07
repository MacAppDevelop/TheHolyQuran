//
//  iPhoneText.swift
//  TheHolyQuran
//
//  Created by No one on 4/5/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func iPhoneText(_ text: String) -> some View {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            Text(text)
        } else {
            EmptyView()
        }
        #else
        EmptyView()
        #endif
    }
}
