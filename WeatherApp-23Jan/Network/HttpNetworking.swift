//
//  HttpNetworking.swift
//  WeatherApp-iOS
//
//  Created by rentamac on 1/27/26.
//


import Foundation


class HttpNetworking: Networking {
    func request<T: Decodable>(endpoint: APIEndpoint, responseType: T.Type) async throws -> T {
        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200...300 ~= httpResponse.statusCode else {
            fatalError("Unexpected response from server")
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
