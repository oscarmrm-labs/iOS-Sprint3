import Foundation

class DetailViewModel: ObservableObject {
    let latitude = "40.41"
    let longitude = "-3.70"
    
    @Published var detailWeatherResponse: DetailedWeatherResponse?

    func fetchDetailedWeather() {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,sunrise,sunset,uv_index_max,precipitation_sum,rain_sum,showers_sum,snowfall_sum"
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
                let detailedWeatherResponse = try JSONDecoder().decode(DetailedWeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self.detailWeatherResponse = detailedWeatherResponse
                }
            } catch {
                print("Error al decodificar la respuesta: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}
