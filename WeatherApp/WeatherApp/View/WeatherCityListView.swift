//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ramamoorthy on 07/05/24.
//

import SwiftUI

struct WeatherCityListView: View {
    
    @ObservedObject var viewModel = CityViewModel()
        
        var body: some View {
            NavigationView {
                List(viewModel.countries) { country in
                    Section(header: Text(country.name)) {
                        ForEach(country.cities) { city in
                            NavigationLink(destination: CityDetailView(cityName: city.name)) {
                                Text(city.name)
                            }
                        }
                    }
                }
                .navigationTitle("Cities")
                .toolbar {
                    Button(action: {
                        Task {
                            await viewModel.refreshData()
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchCityList()
                }
            }
        }
}

#Preview {
    WeatherCityListView()
}


