import Foundation

struct DetailedWeatherResponse: Codable {
    let daily: DetailedDailyWeather
}

struct DetailedDailyWeather: Codable {
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let apparent_temperature_max: [Double]
    let apparent_temperature_min: [Double]
    let sunrise: [String]
    let sunset: [String]
    let uv_index_max: [Double]
    let precipitation_sum: [Double]
    let rain_sum: [Double]
    let showers_sum: [Double]
    let snowfall_sum: [Double]
}
