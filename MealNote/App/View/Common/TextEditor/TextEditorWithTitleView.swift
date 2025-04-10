//
//  TextEditorWithTitleView.swift
//  MealNote
//
//  Created by mio on 2025/04/10.
//

import SwiftUI

struct TextEditorWithTitleViewParameters {
    let title: String
    let placeholder: String
    let initialHeight: CGFloat
}

struct TextEditorWithTitleView: View {
    private var params: TextEditorWithTitleViewParameters
    @Binding private var text: String
    
    init(_ params: TextEditorWithTitleViewParameters, text: Binding<String>) {
        self.params = params
        self._text = text
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Text(params.title).font(.system(size: 16))
            Spacer()
            TextEditorWithPlaceholderView(params.placeholder, text: $text)
                .frame(
                    maxWidth: UIScreen.main.bounds.width * 2/3,
                    minHeight: params.initialHeight
                )
                .cornerRadius(8)
                .border(.gray, width: 1)
        }
    }
}
