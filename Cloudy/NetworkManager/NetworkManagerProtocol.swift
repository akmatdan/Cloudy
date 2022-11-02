//
//  NetworkManagerProtocol.swift
//  Cloudy
//
//  Created by Daniil Akmatov on 31/10/22.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchCurrentWeather(city: String, completion: @escaping (WeatherModel) -> ())
    func fetchCurrentLocationWeather(lat: String, lon: String, completion: @escaping (WeatherModel) -> ())
    func fetchNextFiveWeatherForecast(city: String, completion: @escaping ([ForecastTemperature]) -> ())
}

