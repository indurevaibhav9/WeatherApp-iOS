import SwiftUI
import CoreData


struct ListView: View {

    @StateObject private var viewModel = ListViewModel()
    @State private var cachedTemperatures: [String: String] = [:]
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(
        entity: WeatherCache.entity(),
        sortDescriptors: []
    )
    private var cachedWeather: FetchedResults<WeatherCache>

    private func cachedTemperature(for location: Location) -> String? {
        let oneHourAgo = Date().addingTimeInterval(-3600)

        for cache in cachedWeather {
            // Compare latitude and longitude with small tolerance if needed
            guard cache.latitude == location.latitude,
                  cache.longitude == location.longitude else { continue }

            // Safely unwrap fetchedAt and ensure it's recent
            guard let fetchedAt = cache.fetchedAt, fetchedAt >= oneHourAgo else { continue }

            // Return the temperature text if available
            if let text = cache.temperature { return text }
        }
        return nil
    }

    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()

                List {
                    ForEach(viewModel.filteredLocations) { location in
                        NavigationLink {
                            DetailView(
                                location: location,
                                context: context
                            )
                        } label: {
                            HStack {
                                Text(location.name)
                                    .font(.headline)
                                    .foregroundStyle(.white)

                                Spacer()

                                VStack {
                                    Image(systemName: location.weather.icon)
                                        .foregroundStyle(.yellow)

                                    if let cachedTemp = cachedTemperature(for: location) {
                                        Text(cachedTemp)
                                            .font(.caption.bold())
                                            .foregroundStyle(.white)
                                    }

                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                        .frame(height: 60)
                    }
                }
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .foregroundStyle(.white)
                        }
                    }

                    ToolbarItem(placement: .principal) {
                        Text("Locations")
                            .foregroundStyle(.white)
                    }
                }
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search Location"
                )
            }
            .scrollContentBackground(.hidden)
        }
        .onAppear {
            print("Cached entries:", cachedWeather.count)
        }

    }
}

