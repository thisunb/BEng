//
//  HomepageView.swift
//  WeatherApp
//
//  Created by user214202 on 5/16/22.
//

import SwiftUI

struct HomepageView: View {
    
    @StateObject var weatherControllerObject = WeatherController()
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black, .blue, .black]), startPoint: .topLeading, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center){
                VStack {
                    Text(weatherControllerObject.weather?.name ?? "Colombo")
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
                Spacer()
                Spacer()
                
                VStack{
                    Text("\(weatherControllerObject.weather?.tempString ?? "25")")
                        .font(.system(size: 60, weight: .bold, design: .rounded))
                        .foregroundColor(.mint)
                        .italic()
                        .padding()
                    
                    Text("°C")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.mint)
                        .italic()
                        .padding()
                        .offset(y: -40)
                }
                Spacer()
                
                VStack{
                    Text(weatherControllerObject.weather?.weather.first?.description.capitalized ?? "Light Rain")
                        .font(.system(size: 26, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .italic()
                        .padding()
                    
                    Image(systemName: weatherControllerObject.weather?.getWeatherIcon(id: weatherControllerObject.weather?.weather.first?.id ?? 0) ?? "cloud")
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .padding()
                }
                Spacer()
            }
        }
        .onAppear{
            Task {
                await weatherControllerObject.getCurrentWeatherData()
            }
        }
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
