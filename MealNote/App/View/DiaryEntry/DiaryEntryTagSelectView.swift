//
//  DiaryEntryTagSelectView.swift
//  MealNote
//
//  Created by mio on 2025/04/06.
//

import SwiftUI

struct DiaryEntryTagSelectView: View {
    @Binding private var tags: [DiaryEntrySelectableButtonItem]
    
    init(tags: Binding<[DiaryEntrySelectableButtonItem]>) {
        self._tags = tags
    }
    
    var body: some View {
        TagCloudLayout(alignment: .topLeading) {
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
