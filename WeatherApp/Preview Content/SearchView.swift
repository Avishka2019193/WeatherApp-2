//
//  SearchView.swift
//  WeatherApp
//
//  Created by Dinil Kumarasiri on 2023-02-17.
//

import SwiftUI

struct SearchView: View {
    @StateObject var networkStore = NetworkStore()
    @State var cityName:String = ""
  
    //@State var sfSymbol: String = ""
    //let sfSymbol: [String] = []
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Weather").font(.largeTitle).bold()
            HStack{
                TextField("City Name", text : $cityName).textFieldStyle(.roundedBorder)
                Button{
                    //button action
                    guard !cityName.isEmpty else { return }
                    
                    print("dev test fetching data")
                    Task{
                        await networkStore.fetchData(cityName: cityName)
                    }
                }label: {
                    Text("Search")
                }
            }
            ScrollView(showsIndicators:false){
                if let data = networkStore.weatherData{
                    HStack{
                        WeatherContentView(image: "aqi.low", title: "\(data.description)", subtitle: "Current Status")
                        
                        WeatherContentView(image: "thermometer.low", title: "\(data.formattedTemp)", subtitle:   "Temperature")
                    }
                    HStack{
                        WeatherContentView(image: "humidity", title: "\(data.humidity)", subtitle: "Humidity")
                        
                        WeatherContentView(image: "speedometer", title: "\(data.visibility)", subtitle:   "Pressure")
                    }
                    HStack{
                        WeatherContentView(image: "wind", title: "\(data.windSpeed)", subtitle: "Wind Speed")
                        
                        WeatherContentView(image: "safari", title: "3.01", subtitle:   "Winds Direction")
                    }
                    HStack{
                        WeatherContentView(image: "cloud", title: "\(data.cloudPrecentage)", subtitle: "Visibility")
                    }
                }
            }
        }
        .padding()// we can pass padding to leading and trailing
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct WeatherContentView: View {
    var image: String
    var title: String
    var subtitle: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20).frame(width: UIScreen.main.bounds.width * 0.45, height: 200).foregroundColor(.gray)
            VStack(spacing: 20){
                Image(systemName: image).font(.system(size: 50))
                Text(title).font(.system(size: 20)).bold()
                Text(subtitle)
            }
        }
    }
}
