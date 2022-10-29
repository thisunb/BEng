//
//  IntervalsView.swift
//  WeatherApp
//
//  Created by user214202 on 5/16/22.
//

import SwiftUI

struct IntervalsView: View {
    
    @StateObject var forecastWeatherControllerObject = ForecastWeatherController()
    @StateObject var searchWeatherControllerObject = SearchWeatherController()
    @State var cityName = "Colombo"
    @State var isUnitToggled = false
    @State var lat = 6.9271
    @State var lon = 79.8612
    public static var checkToggled = false
    
    @State private var displayAlert = false
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black, .blue, .black]), startPoint: .topLeading, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center){
                HStack {
                    TextField("Enter a city", text: $cityName)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(.black)
                        .cornerRadius(30)
                        .padding()
                    
                    Button {
                        Task {
                            if(await searchWeatherControllerObject.getSearchWeatherData(cityName: self.cityName, unitString: isUnitToggled ? "imperial" : "metric") == false){
                                
                                displayAlert.toggle()
                            }
                            
                            lat = searchWeatherControllerObject.weather!.coord.lat
                            lon = searchWeatherControllerObject.weather!.coord.lon
                            
                            await forecastWeatherControllerObject.getForecastWeatherData(lat: lat, lon: lon, unitString: isUnitToggled ? "imperial" : "metric")
                        }
                    } label: {
                        Image (systemName: "magnifyingglass")
                            .padding(.trailing, 30)
                            .foregroundColor(.white)
                    }
                    .alert(isPresented: $displayAlert) {
                        Alert(title: Text("Oops!"), message: Text("Please enter a valid city name."), dismissButton: .default(Text("OK")))
                    }
                }
                
                Toggle(isOn: $isUnitToggled) {
                    Text("Imperial?")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                        .italic()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                VStack {
                    Text(searchWeatherControllerObject.weather?.name ?? "Colombo")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                    
                    let currentWeatherData = forecastWeatherControllerObject.forecastWeather?.current
                    
                    if((currentWeatherData) != nil) {
                    
                        VStack{
                            Text((String(format: "%.1f", currentWeatherData!.temp)))
                                .font(.system(size: 40, weight: .bold, design: .default))
                                .foregroundColor(.mint)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text((currentWeatherData?.displayUnit())!)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.mint)
                                .italic()
                                .padding(.top, -25)
                            
                            HStack {
                                Image(systemName: (searchWeatherControllerObject.weather?.getWeatherIcon(id: currentWeatherData!.weather.first!.id))!)
                                    .resizable()
                                    .foregroundColor(.white)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .padding()
                                
                                VStack {
                                    Text ("\(currentWeatherData!.weather.first!.description.capitalized)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .bold, design: .default))
                                        .padding(1)
                                    
                                    Text ((currentWeatherData?.getDateString(dateInt: currentWeatherData!.dt))!)
                                        .foregroundColor(.white)
                                        .font(.system(size: 14, weight: .medium, design: .default))
                                        .padding(1)
                                }
                                .padding()
                            }
                        }
                    }
                    else{
                        Text("No weather data available!")
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                
                Divider()
                    .background(.white)
                
                VStack(alignment: .center){
                    ScrollView{
                        let forecastWeatherData = forecastWeatherControllerObject.forecastWeather?.hourly
                        
                        if((forecastWeatherData) != nil) {
                            ForEach(0..<forecastWeatherData!.count) { index in
                                let dataForDay = forecastWeatherData![index]
                                let isValidInterval = forecastWeatherData?.first!.checkThreeHourWeatherData(dateInt: dataForDay.dt)
                                
                                if(isValidInterval!){
                                    HStack (alignment: .center, spacing: 5) {
                                        VStack {
                                            HStack {
                                                Image(systemName: (searchWeatherControllerObject.weather?.getWeatherIcon(id: dataForDay.weather.last!.id))!)
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 30, height: 30)
                                                    .padding(20)
                                                    
                                                HStack (spacing: 0){
                                                    VStack {
                                                        Text ("\(dataForDay.weather.first!.description.capitalized)")
                                                            .foregroundColor(.white)
                                                            .font(.system(size: 16, weight: .bold, design: .default))
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .padding(1)
                                                        
                                                        Text ((forecastWeatherData?.first?.getDateString(dateInt: dataForDay.dt))!)
                                                            .foregroundColor(.white)
                                                            .font(.system(size: 14, weight: .medium, design: .default))
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .padding(1)
                                                    }
                                                    
                                                    Text((String(format: "%.1f", dataForDay.temp)) + " " +  ((forecastWeatherData?.first?.displayUnit())!))
                                                    .foregroundColor(.mint)
                                                    .padding(.trailing, 20)
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                                }
                                            }
                                            Divider()
                                                .background(.white)
                                        }
                                    }
                                }
                            }
                        }
                        else{
                            Text("No weather data available!")
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                }
                Spacer()
            }
        }
        .onAppear{
            Task {
                print(await searchWeatherControllerObject.getSearchWeatherData(cityName: self.cityName, unitString: isUnitToggled ? "imperial" : "metric"))
                
                lat = (searchWeatherControllerObject.weather?.coord.lat)!
                lon = (searchWeatherControllerObject.weather?.coord.lon)!
                
                await forecastWeatherControllerObject.getForecastWeatherData(lat: lat, lon: lon, unitString: isUnitToggled ? "imperial" : "metric")
            }
        }
        .onChange(of: isUnitToggled, perform: {value in
            Task {
                ForecastView.checkToggled = value
                await forecastWeatherControllerObject.getForecastWeatherData(lat: lat, lon: lon , unitString: isUnitToggled ? "imperial" : "metric")
            }
        })
    }
}

struct IntervalsView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalsView()
    }
}

