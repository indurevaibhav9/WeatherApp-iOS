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
    
    @Published var locations : [Location] = [
        Location(name: "Mumbai", weather: .sunny, temperature: Temperature(min: 22, max: 32)),
        Location(name: "Pune", weather: .rainy, temperature: Temperature(min: 18, max: 28)),
        Location(name: "Delhi", weather: .cloudy, temperature: Temperature(min: 20, max: 30)),
        Location(name: "Bangalore", weather: .sunny, temperature: Temperature(min: 25, max: 35)),
        Location(name: "Hyderabad", weather: .rainy, temperature: Temperature(min: 19, max: 29)),
        Location(name: "Chennai", weather: .cloudy, temperature: Temperature(min: 21, max: 31)),
        Location(name: "Kolkata", weather: .sunny, temperature: Temperature(min: 24, max: 34)),
        Location(name: "Mumbai", weather: .rainy, temperature: Temperature(min: 17, max: 27)),
        Location(name: "Delhi", weather: .cloudy, temperature: Temperature(min: 19, max: 29)),
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
