//
//  LimitNumericTextField.swift
//  TheHolyQuran
//
//  Created by No one on 4/5/23.
//

import SwiftUI

// Used to limit surahNumber and ayaNumber in GoToPopover.swift
extension Binding where Value == Int64? {
    func limitNumber(min: Int64, max: Int64) -> Self {
        if let value = self.wrappedValue, value > max {
            DispatchQueue.main.async {
                self.wrappedValue = max
            }
        } else if let value = self.wrappedValue, value < min {
            DispatchQueue.main.async {
                self.wrappedValue = min
            }
        }
        return self
    }
}
