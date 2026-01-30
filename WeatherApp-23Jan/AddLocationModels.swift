//
//  AddLocationModels.swift
//  WeatherApp-iOS
//
//  Created by rentamac on 1/30/26.
//

struct GeoResponse: Codable {
    let results: [GeoLocation]
}

struct GeoLocation: Codable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    let admin1: String
}
