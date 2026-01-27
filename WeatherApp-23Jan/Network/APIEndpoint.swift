//
//  APIEndpoint.swift
//  WeatherApp-iOS
//
//  Created by rentamac on 1/26/26.
//
import Foundation

protocol APIEndpoint {
    var baseURL : String {get}
    var path: String {get}
    var queryItems: [URLQueryItem] {get}
}

extension APIEndpoint {
    var url : URL? {
        var component = URLComponents(string: baseURL)
        component?.path = path
        component?.queryItems = queryItems
        return component?.url;
    }
}
