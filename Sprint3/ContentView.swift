import SwiftUI

struct ContentView: View {
    let formato: String = "%.1f"
    
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                if let currentWeather = viewModel.currentWeather {
                    Text("Madrid").font(.custom("", size: 24))
                    Text("\(currentWeather.current.temperature_2m, specifier: formato)°").font(.custom("", size: 52))
                    HStack{
                        Text("Min.: \(currentWeather.daily.temperature_2m_min.first ?? 0.0, specifier: formato)°")
                        Text("Max.: \(currentWeather.daily.temperature_2m_max.first ?? 0.0, specifier: formato)°")
                    }
                    HStack{
                        Text("\(currentWeather.daily.sunrise.first ?? "")")
                        Text("\(currentWeather.daily.sunset.first ?? "")")
                    }
                } else {
                    Text("Loading...")
                }
                VStack {
                    if let weather = viewModel.weather {
                        ForEach(0..<weather.daily.time.count, id: \.self) { index in
                            NavigationLink(destination: WeatherDetailView(
                                date: weather.daily.time[index])){
                                    VStack{
                                        HStack() {
                                            Text("\(weather.daily.time[index])")
                                            Text("\(weather.daily.rain_sum[index], specifier: formato)") //cargar icono
                                            Text("Min.: \(weather.daily.temperature_2m_min[index], specifier: formato)°")
                                            Text("Max.: \(weather.daily.temperature_2m_max[index], specifier: formato)°")
                                        }
                                        if index < weather.daily.time.count - 1 {
                                            Divider()
                                        }
                                    }
                                }
                        }
                    } else {
                        Text("Loading...")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 10)
                .buttonStyle(PlainButtonStyle())
            }
            .onAppear {
                viewModel.fetchCurrentWeather()
                viewModel.fetchWeather()
            }
            .padding()
        }
    }
}

