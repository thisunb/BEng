//
//  Weather.swift
//  WeatherApp
//
//  Created by user214202 on 5/16/22.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
    let clouds: Clouds
    let wind: Wind
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

struct Clouds: Decodable{
    let all: Int
}
