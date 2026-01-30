//
//  AddLocationVie.swift
//  WeatherApp-iOS
//
//  Created by rentamac on 1/30/26.
//

import SwiftUI
import MapKit

struct AddLocationView: View {
    
    @ObservedObject var listViewModel: ListViewModel
    
    @State private var showAddedAlert: Bool = false
    @State private var showAlertMessage : String = ""
    
    @State private var searchText: String = ""
    @State private var searchResult: GeoLocation?
    
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 20.5937, longitude: 78.9629),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        VStack(spacing: 16) {
            
            // MARK: - Search Bar
            HStack(spacing: 12) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search location", text: $searchText)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                }
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                Button {
                    fetchLocation()
                } label: {
                    Text("Go")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)

            
            // MARK: - Result Row
            if let result = searchResult {
                Button {
                    focusOnMap(result)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(result.name)
                                .font(.headline)
                            Text("\(result.admin1), \(result.country)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "map")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // MARK: - Add Button
                Button("Add Location") {
                    addLocation(result)
                }
                .buttonStyle(.bordered)
            }
            
            Map(position: $cameraPosition) {
                // No overlays/annotations yet; using content builder initializer to avoid deprecation
            }
            .cornerRadius(12)
            .padding()
            
            Spacer()
        }
        .navigationTitle("Add Location")
        .overlay {
            if showAddedAlert {
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.green)

                    Text("Success")
                        .font(.headline)

                    Text(showAlertMessage)
                        .font(.subheadline)

                    Button("OK") {
                        showAddedAlert = false
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .shadow(radius: 10)
            }
        }
    }
    
    // MARK: - API Call
    private func fetchLocation() {
        guard !searchText.isEmpty else { return }
        
        let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://geocoding-api.open-meteo.com/v1/search?name=\(query)&count=1"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else { return }
            
            if let decoded = try? JSONDecoder().decode(GeoResponse.self, from: data),
               let first = decoded.results.first {
                DispatchQueue.main.async {
                    self.searchResult = first
                    focusOnMap(first)
                }
            }
        }.resume()
    }
    
    // MARK: - Map Focus
    private func focusOnMap(_ location: GeoLocation) {
        let newRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            ),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        cameraPosition = .region(newRegion)
    }
    
    // MARK: - Add to ListViewModel
    private func addLocation(_ location: GeoLocation) {
        
        let alreadyExists = listViewModel.locations.contains {
            $0.name  == location.name
        }
        
        guard !alreadyExists else {
            showAddedAlert.toggle()
            showAlertMessage = "You've already added this location."
            return
        }
        
        let newLocation = Location(
            name: location.name,
            weather: .sunny,
            temperature: nil,
            latitude: location.latitude,
            longitude: location.longitude
        )
        
        listViewModel.locations.insert(newLocation, at: 0)
        showAddedAlert.toggle()
        showAlertMessage = "Successfully added the location."
        
        searchText = ""
        searchResult = nil
    }

}
