//
//  MealLogData.swift
//  MealNote
//
//  Created by mio on 2025/03/12.
//

import UIKit

struct MealLogList: Decodable {
    let date: String
    let meals: [MealLog]
    
    private enum CodingKeys: String, CodingKey {
        case date
        case meals
    }
    
    struct MealLog: Decodable {
        let id: Int
        let date: String
        let title: String?
        let description: String?
        let tags: [String]
        let imageURL: URL?
        let mealType: MealType
        
        private enum CodingKeys: String, CodingKey {
            case id
            case date
            case title
            case description
            case tags
            case imageURL = "imageUrl"
            case mealType
        }
    }
}

public enum MealType: Decodable {
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        switch rawValue.lowercased() {
        case "breakfast":
            self = .breakfast
        case "lunch":
            self = .lunch
        case "dinner":
            self = .dinner
        case "snack":
            self = .snack
        default:
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid meal type: \(rawValue)"
            )
        }
    }
}
