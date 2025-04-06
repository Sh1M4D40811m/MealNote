//
//  MediumEmphasisButton.swift
//  MealNote
//
//  Created by mio on 2025/03/31.
//

import SwiftUI

struct MediumEmphasisButton: View {
    var title: String
    var action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title).frame(height: 40)
        }
        .buttonStyle(OutlinedCircleButtonStyle())
    }
}
