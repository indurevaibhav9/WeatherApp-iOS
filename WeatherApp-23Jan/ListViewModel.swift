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
            name: "Pune",
            weather: .rainy,
            temperature: nil,
            latitude: 18.5204,
            longitude: 73.8567
        ),
        Location(
            name: "Delhi",
            weather: .cloudy,
            temperature: nil,
            latitude: 28.6139,
            longitude: 77.2090
        ),
        Location(
            name: "Bangalore",
            weather: .sunny,
            temperature: nil,
            latitude: 12.9716,
            longitude: 77.5946
        ),
        Location(
            name: "Hyderabad",
            weather: .rainy,
            temperature: nil,
            latitude: 17.3850,
            longitude: 78.4867
        ),
        Location(
            name: "Chennai",
            weather: .cloudy,
            temperature:nil,
            latitude: 13.0827,
            longitude: 80.2707
        ),
        Location(
            name: "Kolkata",
            weather: .sunny,
            temperature: nil,
            latitude: 22.5726,
            longitude: 88.3639
        ),
        Location(
            name: "Mumbai",
            weather: .rainy,
            temperature: nil,
            latitude: 19.0760,
            longitude: 72.8777
        )
        
    ]

    var filteredLocations: [Location] { // computed property
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
