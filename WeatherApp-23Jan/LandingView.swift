//
//  ContentView.swift
//  WeatherApp-23Jan
//
//  Created by rentamac on 1/22/26.
//

import SwiftUI

struct LandingView: View {
    @State private var navigationState = false
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Image("Image")
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                    Text("Breeze")
                        .font(Font.largeTitle)
                        .foregroundStyle(Color.white)
                    Text("Weather App")
                        .foregroundStyle(Color.gray)
                    Spacer()
                    Button(action: {
                        navigationState = true
                    }){
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 60)
                            .background(.white)
                            .clipShape(Circle())
                            .padding(1)
                            .shadow(radius:4)
                    }
                    .navigationDestination(isPresented: $navigationState) {
                        ListView()
                            .environment(\.managedObjectContext, context)
                    }
                        
                }
                .padding()
            }
        }
        .onAppear {
            printDetails()
        }
    }
        
}

func printDetails() {
    if let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String {
          print("baseURL: https://\(baseURL)")
        }
        
        if let enabled = Bundle.main.object(forInfoDictionaryKey: "ANALYTICS_ENABLED") as? String {
          print("ANALYTICS_ENABLED: \(enabled)")
        }
        
        if let config = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
          print("CONFIGURATION: \(config)")
        }

        if let envVar = ProcessInfo.processInfo.environment["ENV_WEA"] {
          print("envVar: \(envVar)")
        }
}

#Preview {
    LandingView()
}
