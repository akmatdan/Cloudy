//
//  IntExtension.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 1/11/22.
//

import UIKit

extension Int {
    func incrementWeekDays(by num: Int) -> Int {
        let incrementedVal = self + num
        let mod = incrementedVal % 7
        
        return mod
    }
}

