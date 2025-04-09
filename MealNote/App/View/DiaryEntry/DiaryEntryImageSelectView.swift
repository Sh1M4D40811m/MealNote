//
//  DiaryEntryImageSelectView.swift
//  MealNote
//
//  Created by mio on 2025/04/09.
//

import SwiftUI
import PhotosUI

struct DiaryEntryImageSelectView: View {
    @Binding private var selectedItems: [PhotosPickerItem]
    @Binding private var selectedImages: [UIImage]
    
    init(selectedItems: Binding<[PhotosPickerItem]>, selectedImages: Binding<[UIImage]>) {
        self._selectedItems = selectedItems
        self._selectedImages = selectedImages
    }
    
    var body: some View {
        PhotosPicker(
            selection: $selectedItems,
            maxSelectionCount: 1,
            selectionBehavior: .ordered,
            matching: .images
        ) {
            imageSelectCard
        }
        .onChange(of: selectedItems) { _, newItems in
            Task {
                selectedItems = []
                selectedImages = []
                for item in newItems {
                    guard let data = try await item.loadTransferable(type: Data.self) else { continue }
                    guard let uiImage = UIImage(data: data) else { continue }
                    selectedImages.append(uiImage)
                }
            }
        }
    }
    
    private var imageSelectCard: some View {
        ZStack {
            Color.white
                .cornerRadius(8)
                .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
            HStack {
                imagePreview
                Spacer()
                Text("画像を追加")
                    .foregroundColor(.teal)
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.trailing, 16)
            }
        }
    }
        
    
    @ViewBuilder
    private var imagePreview: some View {
        if !selectedImages.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(selectedImages.enumerated()), id: \.element) { index, image in
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 75)
                                .clipped()
                            Button(action: {
                                selectedImages.remove(at: index)
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .background(Circle().fill(Color.white))
                            })
                            .frame(width: 24, height: 24)
                            .offset(x: 12, y: -12)
                        }
                        .padding(16)
                    }
                }
            }
        } else {
            ZStack {
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5, 5]))
                    .frame(width: 100, height: 75)
                    .foregroundColor(.gray)
                Image(systemName: "photo.badge.plus").foregroundColor(.gray)
            }
            .padding(16)
        }
    }
}
