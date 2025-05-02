//
//  Extension+Date.swift
//  MealNote
//
//  Created by mio on 2025/03/03.
//

import Foundation

enum DateFormat: String {
    case date = "yyyy/M/d" // 2023/1/1
    case time = "HH:mm"     // 1:00
    case dateTimeJp = "yyyy年M月d日 H時mm分" // 2023年1月1日 1時00分
    case dateWeekJp = "yyyy年M月d日(EE)" // 2023年1月1日(日)
    case dateHyphen = "yyyy-MM-dd" // 2023-01-01
}

extension Locale {
    static let japan = Locale(identifier: "ja_JP")
}

extension Date {
    func toString(_ format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = .japan
        return dateFormatter.string(from: self)
    }
}
