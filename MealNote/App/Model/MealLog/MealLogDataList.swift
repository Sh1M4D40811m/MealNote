//
//  MealLogDataList.swift
//  MealNote
//
//  Created by mio on 2025/03/01.
//

import UIKit

enum MealLogDataList {
    case basic(value: MealLogData, screen: DisplayScreenType)
    
    var cellClass: UITableViewCell.Type {
        MealLogCell.self
    }
    
    enum DisplayScreenType {
        case diary
        case review
    }
}
