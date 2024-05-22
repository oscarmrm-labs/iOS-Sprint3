import SwiftUI
import SVProgressHUD

struct ContentView: View {
    let formato: String = "%.1f"
    
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                if viewModel.loading == true {
                    ProgressView()
                }
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
                } 
                VStack {
                    if let weather = viewModel.weather {
                        ForEach(0..<weather.daily.time.count, id: \.self) { day in
                            NavigationLink(destination: WeatherDetailView(
                                date: weather.daily.time[day])){
                                    VStack{
                                        HStack() {
                                            Text("\(weather.daily.time[day])")
                                            Text("\(weather.daily.rain_sum[day], specifier: formato)") //cargar icono
                                            Text("Min.: \(weather.daily.temperature_2m_min[day], specifier: formato)°")
                                            Text("Max.: \(weather.daily.temperature_2m_max[day], specifier: formato)°")
                                        }
                                        if day < weather.daily.time.count - 1 {
                                            Divider()
                                        }
                                    }
                                }
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 10)
                .buttonStyle(PlainButtonStyle())
            }
            .onAppear {
                //viewModel.fetchCurrentWeather()
                //viewModel.fetchWeather()
                viewModel.fetchData()
            }
            .padding()
        }
    }
}

