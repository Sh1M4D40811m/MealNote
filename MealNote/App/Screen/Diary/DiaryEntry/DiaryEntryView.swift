//
//  DiaryEntryView.swift
//  MealNote
//
//  Created by mio on 2025/03/22.
//

import SwiftUI
import PhotosUI

struct DiaryEntryView: View {
    var dismissAction: (_ isCancel: Bool) -> Void = { _ in }
    
    private var titleInputParams = TextEditorWithTitleViewParameters(
        title: "タイトル",
        placeholder: "メイン料理など（例：焼き鮭、唐揚げ...）",
        initialHeight: 80
    )
    
    private var memoInputParams = TextEditorWithTitleViewParameters(
        title: "メモ",
        placeholder: "付け合わせなど（例：白米、味噌汁...）",
        initialHeight: 120
    )
    
    @State private var selectedDate = Date()
    @State private var isShowDatePicker = false
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    @State private var titleText = ""
    @State private var memoText = ""
    // FIXME: Delete Sample
    @State var mealType: [DiaryEntrySelectableButtonItem] = [
        .init(title: "朝食", isSelected: true),
        .init(title: "昼食"),
        .init(title: "夕食"),
        .init(title: "間食")
    ]
    @State var tags: [DiaryEntrySelectableButtonItem] = [
        .init(title: "米"),
        .init(title: "パン"),
        .init(title: "糖質制限"),
        .init(title: "食後血糖値140以上"),
        .init(title: "野菜"),
        .init(title: "肉"),
        .init(title: "魚"),
        .init(title: "脂肪分"),
        .init(title: "糖質"),
        .init(title: "大盛り"),
        .init(title: "外食"),
        .init(title: "自炊")
    ]
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            contents
            // TODO: デザイン再考する
//            bottomButton
        }
        .toolbar(content: toolbar)
    }
    
    private var contents: some View {
        ScrollView {
            VStack(spacing: 24) {
                DiaryEntryDateSelectView(selectedDate: $selectedDate, isShowDatePicker: $isShowDatePicker)
                Divider()
                DiaryEntryMealTypeSelectView(mealType: $mealType)
                Divider()
                TextEditorWithTitleView(titleInputParams, text: $titleText)
                TextEditorWithTitleView(memoInputParams, text: $memoText)
                DiaryEntryImageSelectView(selectedItems: $selectedItems, selectedImages: $selectedImages)
                Divider()
                DiaryEntryTagSelectView(tags: $tags)
            }
            .padding(16)
            .padding(.bottom, 54)
        }
    }
    
    private var bottomButton: some View {
        MediumEmphasisButton(title: "マイセット呼び出し") {
            dismissAction(false)
        }.padding(16)
    }
    
    @ToolbarContentBuilder
    private func toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                dismissAction(true)
            } label: {
                Text("キャンセル")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.teal)

            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                dismissAction(false)
            } label: {
                Text("保存")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.teal)

            }
        }
    }
}
