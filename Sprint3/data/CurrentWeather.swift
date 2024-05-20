import Foundation

struct CurrentWeatherResponse: Codable {
    let current: CurrentWeather
    let daily: CurrentDayWeather
}

struct CurrentWeather: Codable {
    let temperature_2m: Double
    let is_day: Int
    let rain: Double
    let showers: Double
    let snowfall: Double
}

struct CurrentDayWeather: Codable {
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let sunrise: [String]
    let sunset: [String]
}
