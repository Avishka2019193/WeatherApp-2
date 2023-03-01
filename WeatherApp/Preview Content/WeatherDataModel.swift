//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by user231229 on 2/17/23.
//

import Foundation

struct WeatherDataModel {
    let name: String
    let description: String
    let temp: Double
    let pressure: Int
    let humidity: Int
    let feelsLike: Double
    let visibility: Int
    let windSpeed: Double
    let cloudPrecentage: Int
    
    var formattedTemp: String {
        return String(format: "%.1f",temp)
    }
}
