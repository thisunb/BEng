//
//  SearchWeatherController.swift
//  WeatherApp
//
//  Created by user214202 on 5/17/22.
//

import Foundation

class SearchWeatherController: ObservableObject {
    
    let INITIAL_SEARCH_WEATHER_URL: String = "https://api.openweathermap.org/data/2.5/weather?q="
    
    @Published var weather: WeatherData?
    
    // --- Function for fetching search weather data ---
    
    func getSearchWeatherData(cityName:String, unitString: String) async -> Bool  {
        
        let searchWeatherUrl = "\(INITIAL_SEARCH_WEATHER_URL)\(cityName)&appid=\(API.API_KEY)&units=\(unitString)"
        print(searchWeatherUrl)

        guard let searchWeatherUrl = URL(string: searchWeatherUrl) else {return true}
        
        do {
            let (data, _) = try await URLSession.shared.data(from: searchWeatherUrl)
            let weatherData =  try JSONDecoder().decode(WeatherData.self, from: data)
            print(weatherData)
            DispatchQueue.main.async {
                self.weather = weatherData
            }
            return true
        }
        catch{
            print(error.localizedDescription)
            return false
        }
    }
}
