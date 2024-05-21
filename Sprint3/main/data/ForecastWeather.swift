import Foundation

struct WeatherResponse: Codable {
    let daily: DailyWeather
}

struct DailyWeather: Codable {
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let rain_sum: [Double]
    let showers_sum: [Double]
    let snowfall_sum: [Double]
    let time: [String]
}
