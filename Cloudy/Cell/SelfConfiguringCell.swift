//
//  SelfConfiguringCell.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 1/11/22.
//

import UIKit

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with item: ForecastTemperature)
}
