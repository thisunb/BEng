//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by user214202 on 5/16/22.
//

import Foundation
import SwiftUI

struct WeatherData: Decodable {
    let coord: Coord
    let name: String
    let weather: [Weather]
    let main: Main
    let clouds: Clouds
    let wind: Wind
    
    var tempString: String {
        return String(format: "%.1f", main.temp)
    }
    
    var detailedWeatherData: [WeatherDetailedData] {
        return [
            .init(id: "id_temp", heading: "Temperature", icon: "thermometer", color: Color.red, value: tempString, unit: SearchView.checkToggled ? "°F" : "°C"),
            .init(id: "id_humidity", heading: "Humidity", icon: "drop.fill", color: Color.blue, value: String(main.humidity), unit: "%"),
            .init(id: "id_pressure", heading: "Pressure", icon: "digitalcrown.horizontal.press.fill", color: Color.green, value: String(main.pressure), unit: "hPa"),
            .init(id: "id_wind_speed", heading: "Wind Speed", icon: "wind", color: Color.orange, value: String(wind.speed), unit: SearchView.checkToggled ? "mph" : "m/s"),
            .init(id: "id_wind_direction", heading: "Wind direction", icon: "arrow.up.left.circle", color: Color.yellow, value: getWindDirectionString(degree: wind.deg)),
            .init(id: "id_cloud_percentage", heading: "Cloud Percentage", icon: "icloud", color: Color.cyan, value: String(clouds.all), unit: "%"),
        ]
    }
    
    func getWindDirectionString(degree: Int) -> String {
        switch (degree) {
        case 349...360:
            return "N"
        case 0...11:
            return "N"
        case 11...34:
            return "NNE"
        case 34...56:
            return "NE"
        case 56...79:
            return "ENE"
        case 79...101:
            return "E"
        case 101...124:
            return "ESE"
        case 124...146:
            return "SE"
        case 146...169:
            return "SSE"
        case 169...191:
            return "S"
        case 191...214:
            return "SSW"
        case 214...236:
            return "SW"
        case 236...259:
            return "WSW"
        case 259...281:
            return "W"
        case 281...304:
            return "WNW"
        case 304...326:
            return "NW"
        case 326...349:
            return "NNW"
        default:
            return "N"
        }
    }
    
    func getWeatherIcon(id: Int) -> String {
        switch (id) {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

struct Main: Decodable {
    let temp: Double
    let pressure: Int
    let humidity: Int
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
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

struct WeatherDetailedData: Identifiable {
    var id: String
    let heading: String
    let icon: String
    let color: Color
    let value: String
    var unit: String = ""
}
