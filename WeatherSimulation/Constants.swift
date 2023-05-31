//
//  Constants.swift
//  WeatherSimulation
//
//  Created by Steven Wijaya on 30.05.2023.
//

import Foundation

let SUNNY: Weather = Weather(state: 1, description: "Clear", image: "sun.max.fill")
let CLOUDY: Weather = Weather(state: 2, description: "Cloudy", image: "cloud.sun.fill")
let RAINY: Weather = Weather(state: 3, description: "Rainy", image: "cloud.sun.rain.fill")

func getWeatherState(_ state: Int) -> Weather {
    if state == 1 {
        return SUNNY
    } else if state == 2 {
        return CLOUDY
    } else {
        return RAINY
    }
}

let Q: [[Double]] = [
    [-0.4, 0.3, 0.1],
    [0.4, -0.8, 0.4],
    [0.1, 0.4, -0.5]
]
