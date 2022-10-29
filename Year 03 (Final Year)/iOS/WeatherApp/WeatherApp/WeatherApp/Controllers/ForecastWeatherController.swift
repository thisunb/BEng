//
//  ForecastWeatherController.swift
//  WeatherApp
//
//  Created by user214202 on 5/19/22.
//

import Foundation

class ForecastWeatherController: ObservableObject {
    
    let INITIAL_FORECAST_WEATHER_URL: String = "https://api.openweathermap.org/data/2.5/onecall?"
    
    @Published var forecastWeather: ForecastWeatherData?
    
    // --- Function for fetching forecast weather data ---
    
    func getForecastWeatherData(lat: Double, lon: Double, unitString: String) async {
        
        let forecastWeatherUrl = "\(INITIAL_FORECAST_WEATHER_URL)lat=\(String(lat))&lon=\(String(lon))&exclude=minutely&appid=\(API.API_KEY)&units=\(unitString)"
        
        print(forecastWeatherUrl)

        guard let forecastWeatherUrl = URL(string: forecastWeatherUrl) else {return}
        
        do {
            let (data, _) = try await URLSession.shared.data(from: forecastWeatherUrl)
            let forecastWeatherData =  try JSONDecoder().decode(ForecastWeatherData.self, from: data)
            print(forecastWeatherData)
            DispatchQueue.main.async {
                self.forecastWeather = forecastWeatherData
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
