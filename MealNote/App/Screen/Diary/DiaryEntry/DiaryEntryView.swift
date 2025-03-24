//
//  DiaryEntryView.swift
//  MealNote
//
//  Created by mio on 2025/03/22.
//

import SwiftUI

struct DiaryEntryView: View {
    var dismissAction: (_ isCancel: Bool) -> Void = { _ in }
    
    var body: some View {
        ZStack {
            Text("Hello, World!")
        }
        .toolbar(content: toolbar)
    }
    
    @ToolbarContentBuilder
    private func toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                dismissAction(true)
            } label: {
                Text("キャンセル")
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                dismissAction(false)
            } label: {
                Text("保存")
            }
        }
    }
}

#Preview {
    DiaryEntryView()
}
