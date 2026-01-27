//
//  Networking.swift
//  WeatherApp-iOS
//
//  Created by rentamac on 1/27/26.
//

protocol Networking {
    func request<T: Decodable>( endpoint: APIEndpoint, responseType: T.Type) async throws -> T
}
