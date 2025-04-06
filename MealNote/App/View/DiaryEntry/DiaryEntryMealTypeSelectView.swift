//
//  DiaryEntryMealTypeSelectView.swift
//  MealNote
//
//  Created by mio on 2025/04/06.
//

import SwiftUI

struct DiaryEntryMealTypeSelectView: View {
    @Binding private var mealType: [SelectableButtonItem]
    
    init(mealType: Binding<[SelectableButtonItem]>) {
        self._mealType = mealType
    }
        
    var body: some View {
        TagCloudLayout(alignment: .topLeading) {
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
