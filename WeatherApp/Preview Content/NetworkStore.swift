//
//  NetworkStore.swift
//  WeatherApp
//
//  Created by user231229 on 2/17/23.
//

import Foundation

class NetworkStore: ObservableObject{
    
    @Published var weatherData: WeatherDataModel? //used published annotate as a property wrapper
    
    private var baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(APIConstants.KEY)&units=metric"
    
    func fetchData(cityName: String ) async{
        var urlString = "\(baseURL)&q=\(cityName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        //"https://api.openweathermap.org/data/2.5/weather?appid=57b7593a693d72f537632116ba85b18e&units=metric&q=galle"
        
        //URL
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
            
        }
        
        //URLSession
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            //Decode
            let decodableData = try JSONDecoder().decode(WeatherDTO.self, from: data)
            
            DispatchQueue.main.async{
                self.weatherData = WeatherDataModel(name: decodableData.name,
                                                    description: decodableData.weather[0].description.capitalized,
                                               temp: decodableData.main.temp,
                                               pressure: decodableData.main.pressure,
                                               humidity:decodableData.main.humidity,
                                               feelsLike: decodableData.main.feelsLike,
                                               visibility: decodableData.visibility,
                                               windSpeed: decodableData.wind.speed,
                                               cloudPrecentage: decodableData.clouds.all)
            }
        }catch{
            print("error")
            
        }
        
    }
    
}
