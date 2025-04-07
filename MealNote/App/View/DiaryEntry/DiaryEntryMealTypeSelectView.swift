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
    
    private func selectMealType(_ selectedType: DiaryEntrySelectableButtonItem) {
        for index in mealType.indices {
            mealType[index].isSelected = (mealType[index].id == selectedType.id)
        }
    }
        
    var body: some View {
        TagCloudLayout(alignment: .topLeading, spacing: 8) {
            ForEach($mealType) { $type in
                SelectableButton(
                    title: type.title,
                    isSelected: $type.isSelected,
                    action: {
                        selectMealType(type)
                    }
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
