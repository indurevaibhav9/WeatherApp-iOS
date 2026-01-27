//
//  WeatherInforView.swift
//  WeatherApp-iOS
//
//  Created by rentamac on 1/27/26.
//
import SwiftUI

struct WeatherInfoView: View {
    let icon: String
    let value: String
    let title: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)

            Text(value)
                .font(.headline)

            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .foregroundStyle(.white)
    }
}
