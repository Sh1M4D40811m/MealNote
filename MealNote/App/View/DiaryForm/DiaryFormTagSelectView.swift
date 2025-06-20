//
//  DiaryFormTagSelectView.swift
//  MealNote
//
//  Created by mio on 2025/04/06.
//

import SwiftUI

struct DiaryFormSelectableButtonItem: Identifiable {
    let id = UUID()
    let title: String
    var isSelected: Bool = false
}

struct DiaryFormTagSelectView: View {
    @Binding private var tags: [DiaryFormSelectableButtonItem]
    
    init(tags: Binding<[DiaryFormSelectableButtonItem]>) {
        self._tags = tags
    }
    
    var body: some View {
        TagCloudLayout(alignment: .topLeading, spacing: 8) {
            ForEach($tags) { $tag in
                SelectableButton(
                    title: tag.title,
                    isSelected: $tag.isSelected,
                    action: {}
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
