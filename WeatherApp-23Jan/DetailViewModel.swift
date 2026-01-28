import Foundation
import SwiftUI
import Combine
import CoreData

@MainActor
final class DetailViewModel: ObservableObject {

    // MARK: - UI State
    @Published var temperatureText = "--"
    @Published var windText = "--"
    @Published var humidityText = "--"
    @Published var conditionText = "--"
    @Published var conditionIcon = "questionmark"
    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Dependencies
    private let weatherService: WeatherServiceProtocol
    private let context: NSManagedObjectContext

    init(
        context: NSManagedObjectContext,
        weatherService: WeatherServiceProtocol = WeatherService(
            networkingServie: HttpNetworking()
        )
    ) {
        self.context = context
        self.weatherService = weatherService
    }

    // MARK: - Public API
    func fetchWeather(latitude: Double, longitude: Double) async {
        isLoading = true
        errorMessage = nil

        if let cached = fetchCachedWeather(latitude: latitude, longitude: longitude),
           isCacheValid(cached.timestamp) {

            applyCache(cached)
            print(cached)
            isLoading = false
            return
        }
        print("first time")
        do {
            let response = try await weatherService.fetchWeather(
                latitude: latitude,
                longitude: longitude
            )

            let current = response.current
            let units = response.currentUnits

            let temp = "\(Int(current.temperature2M)) \(units.temperature2M)"
            let wind = "\(current.windSpeed10M) \(units.windSpeed10M)"
            let humidity = "\(current.relativeHumidity2M)%"

            let weather = mapWeather(code: current.weatherCode)

            updateUI(
                temperature: temp,
                wind: wind,
                humidity: humidity,
                text: weather.text,
                icon: weather.icon
            )

            saveCache(
                latitude: latitude,
                longitude: longitude,
                temperature: temp,
                wind: wind,
                humidity: humidity,
                conditionText: weather.text,
                conditionIcon: weather.icon
            )

        } catch {
            errorMessage = "Unable to fetch weather"
            print(error)
        }

        isLoading = false
    }

    // MARK: - Cache Helpers
    private func fetchCachedWeather(
        latitude: Double,
        longitude: Double
    ) -> WeatherCache? {

        let request: NSFetchRequest<WeatherCache> = WeatherCache.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(
            format: "latitude == %lf AND longitude == %lf",
            latitude,
            longitude
        )

        return try? context.fetch(request).first
    }

    private func isCacheValid(_ date: Date?) -> Bool {
        guard let date else { return false }
        return Date().timeIntervalSince(date) < 3600 // 1 hour
    }

    private func applyCache(_ cache: WeatherCache) {
        temperatureText = cache.temperature ?? "--"
        windText = cache.wind ?? "--"
        humidityText = cache.humidity ?? "--"
        conditionText = cache.conditionText ?? "--"
        conditionIcon = cache.conditionIcon ?? "questionmark"
    }

    private func saveCache(
        latitude: Double,
        longitude: Double,
        temperature: String,
        wind: String,
        humidity: String,
        conditionText: String,
        conditionIcon: String
    ) {
        let cache = fetchCachedWeather(latitude: latitude, longitude: longitude)
            ?? WeatherCache(context: context)

        cache.latitude = latitude
        cache.longitude = longitude
        cache.temperature = temperature
        cache.wind = wind
        cache.humidity = humidity
        cache.conditionText = conditionText
        cache.conditionIcon = conditionIcon
        cache.timestamp = Date()

        try? context.save()
    }

    // MARK: - Weather Mapping
    private func mapWeather(code: Int) -> (text: String, icon: String) {
        switch code {
        case 0: return ("Clear Sky", "sun.max.fill")
        case 1, 2, 3: return ("Partly Cloudy", "cloud.sun.fill")
        case 45, 48: return ("Fog", "cloud.fog.fill")
        case 51, 53, 55: return ("Drizzle", "cloud.drizzle.fill")
        case 61, 63, 65: return ("Rain", "cloud.rain.fill")
        case 71, 73, 75: return ("Snow", "cloud.snow.fill")
        case 95: return ("Thunderstorm", "cloud.bolt.rain.fill")
        default: return ("Unknown", "questionmark")
        }
    }

    // MARK: - UI Helper
    private func updateUI(
        temperature: String,
        wind: String,
        humidity: String,
        text: String,
        icon: String
    ) {
        temperatureText = temperature
        windText = wind
        humidityText = humidity
        conditionText = text
        conditionIcon = icon
    }
}
