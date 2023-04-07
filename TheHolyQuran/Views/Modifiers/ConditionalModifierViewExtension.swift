//
//  ConditionalModifierViewExtension.swift
//  Quran
//
//  Created by No one on 4/2/23.
//

import SwiftUI

extension View {
    // Source: https://www.avanderlee.com/swiftui/conditional-view-modifier/
    // Applies the given transform if the given condition evaluates to `true`.
    // - Parameters:
    //   - condition: The condition to evaluate.
    //   - transform: The transform to apply to the source `View`.
    // - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func conditional<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
