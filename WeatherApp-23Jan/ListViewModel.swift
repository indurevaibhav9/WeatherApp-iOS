//
//  ListViewModel.swift
//  WeatherApp-23Jan
//
//  Created by rentamac on 1/22/26.
//

import SwiftUI
import Combine

final class ListViewModel: ObservableObject {
    
    
    @Published var searchText: String = ""
    
    @Published var locations: [Location] = [
        Location(
            name: "Mumbai",
            weather: .sunny,
            temperature: Temperature(min: 22, max: 32),
            latitude: 19.0760,
            longitude: 72.8777
        ),
        Location(
            name: "Pune",
            weather: .rainy,
            temperature: Temperature(min: 18, max: 28),
            latitude: 18.5204,
            longitude: 73.8567
        ),
        Location(
            name: "Delhi",
            weather: .cloudy,
            temperature: Temperature(min: 20, max: 30),
            latitude: 28.6139,
            longitude: 77.2090
        ),
        Location(
            name: "Bangalore",
            weather: .sunny,
            temperature: Temperature(min: 25, max: 35),
            latitude: 12.9716,
            longitude: 77.5946
        ),
        Location(
            name: "Hyderabad",
            weather: .rainy,
            temperature: Temperature(min: 19, max: 29),
            latitude: 17.3850,
            longitude: 78.4867
        ),
        Location(
            name: "Chennai",
            weather: .cloudy,
            temperature: Temperature(min: 21, max: 31),
            latitude: 13.0827,
            longitude: 80.2707
        ),
        Location(
            name: "Kolkata",
            weather: .sunny,
            temperature: Temperature(min: 24, max: 34),
            latitude: 22.5726,
            longitude: 88.3639
        ),
        Location(
            name: "Mumbai",
            weather: .rainy,
            temperature: Temperature(min: 17, max: 27),
            latitude: 19.0760,
            longitude: 72.8777
        ),
        Location(
            name: "Delhi",
            weather: .cloudy,
            temperature: Temperature(min: 19, max: 29),
            latitude: 28.6139,
            longitude: 77.2090
        )
    ]

    var filteredLocations: [Location] {
        if searchText.isEmpty {
            return locations
        }
        else {
            return locations.filter({
                $0.name.localizedCaseInsensitiveContains(searchText)
            })
        }
    }
    
}  
