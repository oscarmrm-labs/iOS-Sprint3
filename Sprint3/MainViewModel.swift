import Foundation

class WeatherViewModel: ObservableObject {
    let latitude = "40.41"
    let longitude = "-3.70"
    
    @Published var currentWeather: CurrentWeatherResponse?
    @Published var weather: WeatherResponse?

    func fetchCurrentWeather() {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,is_day,rain,showers,snowfall&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset&forecast_days=1"
        guard let url = URL(string: urlString) else {
            print("URL inválida.")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error en la solicitud: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Datos no válidos.")
                return
            }

            do {
                let weatherResponse = try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self.currentWeather = weatherResponse
                }
            } catch {
                print("Error al decodificar la respuesta: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func fetchWeather() {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=temperature_2m_max,temperature_2m_min,rain_sum,showers_sum,snowfall_sum&forecast_days=7&timezone=auto"
        guard let url = URL(string: urlString) else {
            print("URL inválida.")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error en la solicitud: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Datos no válidos.")
                return
            }

            do {
                print("Datos recibidos: \(String(data: data, encoding: .utf8) ?? "No se pudo convertir los datos a String")")
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self.weather = weatherResponse
                }
            } catch {
                print("Error al decodificar la respuesta: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
