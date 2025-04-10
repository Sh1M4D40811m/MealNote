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
    var text: String
}

struct TextEditorWithTitleView: View {
    @Binding private var params: TextEditorWithTitleViewParameters
    
    init(_ params: Binding<TextEditorWithTitleViewParameters>) {
        self._params = params
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Text(params.title).font(.system(size: 16))
            Spacer()
            TextEditorWithPlaceholderView(params.placeholder, text: $params.text)
                .frame(
                    maxWidth: UIScreen.main.bounds.width * 2/3,
                    minHeight: params.initialHeight
                )
                .cornerRadius(8)
                .border(.gray, width: 1)
        }
    }
}
