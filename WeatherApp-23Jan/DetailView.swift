//
//  DetailView.swift
//  WeatherApp-23Jan
//
//  Created by rentamac on 1/22/26.
//

import SwiftUI

struct DetailView: View {
    var location: Location
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor", bundle: nil)
                    .ignoresSafeArea()
                VStack {
                    Text(location.name)
                        .font(Font.largeTitle)
                        .foregroundStyle(.white)
                    Image(systemName: location.weather.icon)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(Color.yellow)
                    Text(location.temperature.temperatureText)
                        .font(.title)
                        .foregroundStyle(Color.gray)
                    Spacer()
                    
                    HStack
                    {
                        Text("A warm breeze drifted through the streets as the afternoon sun hovered behind a veil of scattered clouds. In the north, the air felt dry and dusty, while the southern coast carried the familiar scent of moisture from the sea. Somewhere in the distance, dark monsoon clouds gathered slowly, hinting at an evening shower that would cool the earth and fill the air with the sound of rain tapping on rooftops.")
                            .font(.title)
                            .foregroundStyle(Color.white)
                            .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    DetailView(location: Location(name: "Mumbai", weather: .snow, temperature: Temperature(min: 22,max: 25)))
}
