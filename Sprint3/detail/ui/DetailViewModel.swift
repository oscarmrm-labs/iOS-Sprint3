import Foundation
import Alamofire

class DetailViewModel: ObservableObject {
    let latitude = "40.41"
    let longitude = "-3.70"
    
    @Published var detailWeatherResponse: DetailedWeatherResponse?

    func fetchDetailedWeather(date: String) {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,sunrise,sunset,uv_index_max,precipitation_sum,rain_sum,showers_sum,snowfall_sum&start_date=\(date)&end_date=\(date)"
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let data):
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                self.detailWeatherResponse = try JSONDecoder().decode(DetailedWeatherResponse.self, from: jsonData)
            } catch {
                print(error.localizedDescription)
             }
           case .failure(let error):
             print(error.localizedDescription)
           }
        }
    }
}
