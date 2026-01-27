import Foundation
import SwiftUI
import Combine

@MainActor
final class DetailViewModel: ObservableObject {

    @Published var temperatureText: String = "--"
    @Published var windText: String = "--"
    @Published var humidityText: String = "--"
    @Published var conditionText: String = "--"
    @Published var conditionIcon: String = "questionmark"

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol

    init(
        weatherService: WeatherServiceProtocol = WeatherService(
            networkingServie: HttpNetworking()
        )
    ) {
        self.weatherService = weatherService
    }

    func fetchWeather(latitude: Double, longitude: Double) async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await weatherService.fetchWeather(
                latitude: latitude,
                longitude: longitude
            )

            let current = response.current
            let units = response.currentUnits

            temperatureText = "\(Int(current.temperature2M)) \(units.temperature2M)"
            windText = "\(current.windSpeed10M) \(units.windSpeed10M)"
            humidityText = "\(current.relativeHumidity2M)%"

            let weather = mapWeather(code: current.weatherCode)
            conditionText = weather.text
            conditionIcon = weather.icon

        } catch {
            errorMessage = "Unable to fetch weather"
            print(error)
        }

        isLoading = false
    }

    // MARK: - Weather Code Mapping
    private func mapWeather(code: Int) -> (text: String, icon: String) {
        switch code {
        case 0:
            return ("Clear Sky", "sun.max.fill")
        case 1, 2, 3:
            return ("Partly Cloudy", "cloud.sun.fill")
        case 45, 48:
            return ("Fog", "cloud.fog.fill")
        case 51, 53, 55:
            return ("Drizzle", "cloud.drizzle.fill")
        case 61, 63, 65:
            return ("Rain", "cloud.rain.fill")
        case 71, 73, 75:
            return ("Snow", "cloud.snow.fill")
        case 95:
            return ("Thunderstorm", "cloud.bolt.rain.fill")
        default:
            return ("Unknown", "questionmark")
        }
    }
}
