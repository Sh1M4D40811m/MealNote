//
//  SelectableButtonStyle.swift
//  MealNote
//
//  Created by mio on 2025/04/04.
//

import SwiftUI

struct SelectableButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .frame(minWidth: 50)
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .semibold))
            .background(Capsule().fill(isSelected ? Color.teal : Color.gray))
    }
}
