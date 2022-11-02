//
//  DateExtension.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 1/11/22.
//

import UIKit

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
