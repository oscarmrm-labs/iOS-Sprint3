import SwiftUI

struct WeatherDetailView: View {
    let date: String
    let formato: String = "%.1f"

    @StateObject private var viewModel = DetailViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let detailedWeather = viewModel.detailWeatherResponse {
                HStack {
                    Text("Max. Temp: \(detailedWeather.daily.temperature_2m_max.first ?? 0.0, specifier: formato)°")
                    Spacer()
                    Text("Min. Temp: \(detailedWeather.daily.temperature_2m_min.first ?? 0.0, specifier: formato)°")
                }
                HStack {
                    Text("Temperatura min. aparente: \(detailedWeather.daily.apparent_temperature_min.first ?? 0.0, specifier: formato)°")
                    Spacer()
                    Text("Temperatura max. aparente: \(detailedWeather.daily.apparent_temperature_max.first ?? 0.0, specifier: formato)°")
                }
                HStack {
                    Text("Amanecer: \(detailedWeather.daily.sunrise.first ?? "")")
                    Spacer()
                    Text("Anochecer: \(detailedWeather.daily.sunset.first ?? "")")
                }
                HStack {
                    Text("Índice UV max.: \(detailedWeather.daily.uv_index_max.first ?? 0.0, specifier: formato)")
                }
                Text("Precipitación: \(detailedWeather.daily.precipitation_sum.first ?? 0.0, specifier: formato) mm")
                HStack {
                    Text("Lluvias: \(detailedWeather.daily.rain_sum.first ?? 0.0, specifier: formato) mm")
                    Spacer()
                    Text("Chubsacos: \(detailedWeather.daily.showers_sum.first ?? 0.0, specifier: formato) mm")
                    Spacer()
                    Text("Nevadas: \(detailedWeather.daily.snowfall_sum.first ?? 0.0, specifier: formato) cm")
                }
            } else {
                Text("Loading...")
            }
        }
        .padding()
        .navigationTitle("\(date)")
        .onAppear {
            viewModel.fetchDetailedWeather()
        }
        Spacer()
    }
}
