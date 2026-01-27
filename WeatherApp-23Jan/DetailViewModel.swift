//
//  DetailViewModel.swift
//  WeatherApp-iOS
//
//  Created by rentamac on 1/27/26.
//

import Foundation
import Combine

@MainActor
final class DetailViewModel: ObservableObject {

    @Published var temperatureText: String = "--"
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

            let temp = response.current.temperature2M
            temperatureText = "\(Int(temp)) \(response.currentUnits.temperature2M)"
        } catch {
            errorMessage = "Unable to fetch weather"
            print(error)
        }

        isLoading = false
    }
}
