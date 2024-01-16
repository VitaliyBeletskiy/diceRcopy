//
//  ViewExtensions.swift
//  diceR
//
//  Created by MY on 2024-01-14.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
