//
//  Extension+Date.swift
//  MealNote
//
//  Created by mio on 2025/03/03.
//

import Foundation

enum DateFormat: String {
    case date = "yMd"     // 2023/1/1
    case time = "Hm"     // 1:00
}

extension Locale {
    static let japan = Locale(identifier: "ja_JP")
}

extension DateFormatter {
    func setTemplate(_ format: DateFormat) {
        dateFormat = DateFormatter.dateFormat(fromTemplate: format.rawValue, options: 0, locale: .japan)
    }
}

extension Date {
    func toString(_ format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setTemplate(format)
        return dateFormatter.string(from: self)
    }
}
