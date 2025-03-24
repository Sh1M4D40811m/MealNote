//
//  MealLogData.swift
//  MealNote
//
//  Created by mio on 2025/03/12.
//

import UIKit

public struct MealLogData {
    var image: UIImage?
    var type: MealType
    var title: String
    var description: String?
    var tags: [String]
    var date: Date
}

public enum MealType {
    case breakfast
    case lunch
    case dinner
    case snack
    
    var image: UIImage {
        switch self {
        case .breakfast:
            return UIImage(systemName: "sun.horizon.fill")!
        case .lunch:
            return UIImage(systemName: "sun.max.fill")!
        case .dinner:
            return UIImage(systemName: "moon.fill")!
        case .snack:
            return UIImage(systemName: "cup.and.saucer.fill")!
        }
    }
}
