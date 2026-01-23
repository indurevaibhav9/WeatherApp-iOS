//
//  ListView.swift
//  WeatherApp-23Jan
//
//  Created by rentamac on 1/22/26.
//
import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = ListViewModel()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                List {
                    ForEach(viewModel.filteredLocations) { location in
                        NavigationLink(destination: DetailView(location: location)) {
                            HStack {
                                Text(location.name)
                                    .font(.headline)
                                    .foregroundStyle(Color.white)
                                Spacer()
                                Image(systemName: location.weather.icon)
                                    .foregroundStyle(.yellow)
                                
                            }
                        }.listRowBackground(Color.clear)
                            .frame(height:60)
                    }
                }
                .navigationBarBackButtonHidden()
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        }
                        label: {
                            Image(systemName: "chevron.backward")
                                .foregroundStyle(Color.white)
                        }
                    }
                    ToolbarItem(placement: .principal) {
                         Text("Locations")
                            .foregroundStyle(Color.white)
                    }
                })
                .searchable(text: $viewModel.searchText, prompt: "Search Location")
                
            }.scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    ListView()
}




