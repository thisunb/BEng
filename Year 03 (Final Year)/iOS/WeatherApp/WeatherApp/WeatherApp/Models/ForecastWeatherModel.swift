//
//  ForecastWeatherModel.swift
//  WeatherApp
//
//  Created by user214202 on 5/19/22.
//

import Foundation
import SwiftUI

struct ForecastWeatherData: Decodable {
    let current: CurrentWeather
    let daily: [DailyWeather]
    let hourly: [HourlyWeather]
}

struct CurrentWeather: Decodable {
    let dt: Int
    let temp: Double
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: Double
    let weather: [Weather]
    
    func displayUnit() -> String {
        if(ForecastView.checkToggled){
            return  "°F"
        }
        else{
            return "°C"
        }
    }
    
    func getDateString(dateInt: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "GMT+5.30")
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(((dateInt)))))
    }
    
}

struct DailyWeather: Decodable {
    let dt: Int
    let temp: Temperature
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: Double
    let weather: [Weather]
    
    func getDateString(dateInt: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(((dateInt)))))
    }
    
    func displayUnit() -> String {
        if(ForecastView.checkToggled){
            return  "°F"
        }
        else{
            return "°C"
        }
    }
    
    func displayWindSpeedUnit() -> String{
        if(ForecastView.checkToggled){
            return "mph"
        }
        else{
            return "m/s"
        }
    }
}

struct HourlyWeather: Decodable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
    
    func getDateString(dateInt: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "GMT+5.30")
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(((dateInt)))))
    }
    
    func displayUnit() -> String {
        if(ForecastView.checkToggled){
            return  "°F"
        }
        else{
            return "°C"
        }
    }
    
    func checkThreeHourWeatherData(dateInt: Int) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "GMT+5.30")
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        let stringDate = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(((dateInt)))))
        let finalDate = dateFormatter.date(from: stringDate)
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "GMT+5.30")!
        let hour = calendar.component(.hour, from: finalDate!)
        
        print(stringDate)
        print(hour)
        
        if(hour % 3 == 0){
            return true
        }
        else{
            return false
        }
    }
}

struct Temperature: Decodable {
    let min: Double
    let max: Double
}

struct ForecastWeatherDetailedData: Identifiable {
    let id = UUID()
    let dt: String
    let temp: String
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: String
    let weather: Weather
    let icon: String
}
