//
//  Location.swift
//  WeatherApp-23Jan
//
//  Created by rentamac on 1/22/26.
//

import Foundation

enum Weather {
    case sunny
    case rainy
    case foggy
    case snow
    case windy
    case stormy
    case cloudy
    
    var icon : String {
        switch self {
        case .sunny: return "sun.max"
        case .rainy: return "cloud.rain.fill"
        case .foggy: return "cloud.fog"
        case .snow: return "snow"
        case .windy: return "wind"
        case .stormy: return "cloud.heavyrain.fill"
        case .cloudy: return "cloud"
        }
    }
}
    struct Temperature  {
        let min: Int
        let max: Int
        
        var temperatureText : String {
            "\(min) `C  / \(max) `C"
        }
    }
    
    struct Location : Identifiable {
        let id: UUID = UUID()
        let name: String
        let weather: Weather
        let temperature: Temperature
        let latitude: Double
        let longitude: Double
    }
    

