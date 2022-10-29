//
//  WeatherController.swift
//  WeatherApp
//
//  Created by user214202 on 5/16/22.
//

import Foundation

class WeatherController: ObservableObject {
    
    let INITIAL_CURRENT_WEATHER_URL: String = "https://api.openweathermap.org/data/2.5/weather?"
    
    @Published var weather: WeatherData?
    
    // --- Function for fetching current weather data ---
    
    func getCurrentWeatherData() async {
        
        let latitude = 6.9271
        let longitude = 79.8612
        let currentWeatherUrl = "\(INITIAL_CURRENT_WEATHER_URL)lat=\(latitude)&lon=\(longitude)&appid=\(API.API_KEY)&units=metric"
        print(currentWeatherUrl)

        guard let currentWeatherUrl = URL(string: currentWeatherUrl) else {return}
        
        do {
            let (data, _) = try await URLSession.shared.data(from: currentWeatherUrl)
            let weatherData =  try JSONDecoder().decode(WeatherData.self, from: data)
            print(weatherData)
            DispatchQueue.main.async {
                self.weather = weatherData
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
}


