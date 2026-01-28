//
//  WeatherApp_23JanApp.swift
//  WeatherApp-23Jan
//

import SwiftUI
import CoreData

@main
struct WeatherApp_23JanApp: App {

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LandingView()
                .environment(
                    \.managedObjectContext,
                    persistenceController.container.viewContext
                )
        }
    }
}
