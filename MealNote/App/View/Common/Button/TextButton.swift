//
//  TextButton.swift
//  MealNote
//
//  Created by mio on 2025/04/08.
//

import SwiftUI

struct TextButton: View {
    private let title: String
    private let action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(TextButtonStyle())
    }
}
