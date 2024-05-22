import Foundation
import Alamofire

class WeatherViewModel: ObservableObject {
    let latitude = "40.41"
    let longitude = "-3.70"
    let forecastDays = "1"
    
    @Published var currentWeather: CurrentWeatherResponse?
    @Published var weather: WeatherResponse?
    @Published var loading = true
    
    private let group = DispatchGroup()

    func fetchCurrentWeather() {
        group.enter()
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,is_day,rain,showers,snowfall&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset&forecast_days=\(forecastDays)"
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let data):
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                self.currentWeather = try JSONDecoder().decode(CurrentWeatherResponse.self, from: jsonData)
            } catch {
                print(error.localizedDescription)
             }
           case .failure(let error):
             print(error.localizedDescription)
           }
        }
        group.leave()
    }
    
    func fetchWeather() {
        group.enter()
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=temperature_2m_max,temperature_2m_min,rain_sum,showers_sum,snowfall_sum"
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let data):
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                self.weather = try JSONDecoder().decode(WeatherResponse.self, from: jsonData)
            } catch {
                print(error.localizedDescription)
             }
           case .failure(let error):
             print(error.localizedDescription)
           }
        }
        group.leave()
    }
    
    func fetchData() {
        loading = true
        fetchCurrentWeather()
        fetchWeather()
        
        group.notify(queue: .main) {
            self.loading = false
            print("LOADING ... \(self.loading)")
        }
        
    }
    
}
