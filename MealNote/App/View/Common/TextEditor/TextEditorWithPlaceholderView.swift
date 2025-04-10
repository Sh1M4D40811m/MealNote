//
//  TextEditorWithPlaceholderView.swift
//  MealNote
//
//  Created by mio on 2025/04/10.
//

import SwiftUI

struct TextEditorWithPlaceholderView: View {
    private let placeholder: String
    @Binding private var text: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .font(.system(size: 16))
            Text(placeholder)
                .font(.system(size: 16))
                .opacity(text.isEmpty ? 0.3 : 0.0)
                .padding(.init(top: 8, leading: 8, bottom: 0, trailing: 0))
                .allowsHitTesting(false)
        }
    }
}
