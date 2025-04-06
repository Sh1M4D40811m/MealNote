//
//  DiaryEntryMealTypeSelectView.swift
//  MealNote
//
//  Created by mio on 2025/04/06.
//

import SwiftUI

struct DiaryEntryMealTypeSelectView: View {
    @Binding private var mealType: [DiaryEntrySelectableButtonItem]
    
    init(mealType: Binding<[DiaryEntrySelectableButtonItem]>) {
        self._mealType = mealType
    }
        
    var body: some View {
        TagCloudLayout(alignment: .topLeading, spacing: 8) {
            ForEach($mealType) { $type in
                SelectableButton(
                    title: type.title,
                    isSelected: $type.isSelected,
                    action: {}
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
