//
//  SearchView.swift
//  WeatherApp
//
//  Created by user214202 on 5/16/22.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var searchWeatherControllerObject = SearchWeatherController()
    @State var cityName = "Colombo"
    @State var isUnitToggled = false
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
                        }
                    }
                    
                    label: {
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
                .padding()
                
                VStack {
                    Text(searchWeatherControllerObject.weather?.name ?? "Colombo")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding()
                    
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .padding()
                }
                
                VStack(alignment: .center){
                    ScrollView{
                        let searchWeatherData = searchWeatherControllerObject.weather?.detailedWeatherData
                        if((searchWeatherData) != nil) {
                            
                            ForEach(searchWeatherData!) { weatherElement in
                                
                                HStack{
                                    Image(systemName: weatherElement.icon)
                                        .resizable()
                                        .foregroundColor(.white)
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 20, height: 20)
                                        .padding(20)
                                    
                                    Text(weatherElement.heading)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(weatherElement.value) \(weatherElement.unit)")
                                        .foregroundColor(.mint)
                                        .frame(alignment: .leading)
                                        .padding()
                                }
                                
                            }
                        }
                        else{
                            Text("No weather data available!")
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .padding()
                        }
                    }
                }
                Spacer()
            }
        }
        .onAppear{
            Task {
                await searchWeatherControllerObject.getSearchWeatherData(cityName: self.cityName, unitString: isUnitToggled ? "imperial" : "metric")
            }
        }
        .onChange(of: isUnitToggled, perform: {value in
            Task {
                SearchView.checkToggled = value
                print(await searchWeatherControllerObject.getSearchWeatherData(cityName: self.cityName, unitString: isUnitToggled ? "imperial" : "metric"))
            }
        })
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
