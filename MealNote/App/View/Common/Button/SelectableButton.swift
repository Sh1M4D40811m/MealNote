//
//  SelectableButton.swift
//  MealNote
//
//  Created by mio on 2025/04/04.
//

import SwiftUI

struct SelectableButton: View {
    private let title: String
    @Binding private var isSelected: Bool
    private let action: () -> Void
    
    init(title: String,
         isSelected: Binding<Bool>,
         action: @escaping () -> Void) {
        self.title = title
        self._isSelected = isSelected
        self.action = action
    }

    var body: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            Text(title).multilineTextAlignment(.center)
        }
        .buttonStyle(SelectableButtonStyle(isSelected: isSelected))
    }
}
