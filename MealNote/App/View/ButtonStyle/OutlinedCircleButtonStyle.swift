//
//  OutlinedCircleButtonStyle.swift
//  MealNote
//
//  Created by mio on 2025/04/03.
//

import SwiftUI

struct OutlinedCircleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .foregroundColor(configuration.isPressed ? .teal.opacity(0.5) : .teal)
            .font(.system(size: 16, weight: .semibold))
            .background(Capsule().fill(.white))
            .overlay(
                Capsule()
                    .stroke(configuration.isPressed ? .teal.opacity(0.5) : .teal, lineWidth: 2)
            )
            .animation(.easeOut, value: 0.2)
    }
}
