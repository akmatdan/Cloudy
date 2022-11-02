//
//  Forecast.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 31/10/22.
//

import Foundation

struct WeatherInfo {
    let temp: Float
    let min_temp: Float
    let max_temp: Float
    let description: String
    let icon: String
    let time: String
}

struct ForecastTemperature {
    let weekDay: String?
    let hourlyForecast: [WeatherInfo]?
}
