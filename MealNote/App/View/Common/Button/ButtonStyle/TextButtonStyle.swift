//
//  TextButtonStyle.swift
//  MealNote
//
//  Created by mio on 2025/04/08.
//

import SwiftUI

struct TextButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .teal.opacity(0.5) : .teal)
            .font(.system(size: 16, weight: .semibold))
    }
}
