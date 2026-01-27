//
//  WeatherResponse.swift
//  WeatherApp-iOS
//
//  Created by rentamac on 1/27/26.
//
struct WeatherResponse: Codable {
let latitude, longitude, generationtimeMS: Double
let utcOffsetSeconds: Int
let timezone, timezoneAbbreviation: String
let elevation: Int
let currentUnits: CurrentUnits
let current: Current

enum CodingKeys: String, CodingKey {
case latitude, longitude
case generationtimeMS = "generationtime_ms"
case utcOffsetSeconds = "utc_offset_seconds"
case timezone
case timezoneAbbreviation = "timezone_abbreviation"
case elevation
case currentUnits = "current_units"
case current

}
}

struct Current: Codable {
    let time: String
    let interval: Int
    let temperature2M: Double
    let windSpeed10M: Double
    let relativeHumidity2M: Int
    let weatherCode: Int

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case windSpeed10M = "wind_speed_10m"
        case relativeHumidity2M = "relative_humidity_2m"
        case weatherCode = "weather_code"
    }
}


struct CurrentUnits: Codable {
    let time, interval: String
    let temperature2M: String
    let windSpeed10M: String
    let relativeHumidity2M: String

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case windSpeed10M = "wind_speed_10m"
        case relativeHumidity2M = "relative_humidity_2m"
    }
}

