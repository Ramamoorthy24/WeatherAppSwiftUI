//
//  CityDetailView.swift
//  WeatherApp
//
//  Created by Ramamoorthy on 07/05/24.
//

import SwiftUI

struct CityDetailView: View {
    var cityName: String
    @ObservedObject var viewModel = CityViewModel()
    @State private var error: Error?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let cityDetails = viewModel.cityDetails {
                Text(cityDetails.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    Text("Weather:")
                    Text(cityDetails.weather.first?.main ?? "")
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Description:")
                    Text(cityDetails.weather.first?.description ?? "")
                }
                
                HStack {
                    Text("Temperature:")
                    Text("\(cityDetails.main.temp, specifier: "%.1f") °C")
                }
                
                HStack {
                    Text("Feels Like:")
                    Text("\(cityDetails.main.feels_like, specifier: "%.1f") °C")
                }
                
                HStack {
                    Text("Pressure:")
                    Text("\(cityDetails.main.pressure) hPa")
                }
                
                HStack {
                    Text("Humidity:")
                    Text("\(cityDetails.main.humidity)%")
                }
                
                HStack {
                    Text("Wind Speed:")
                    Text("\(cityDetails.wind.speed, specifier: "%.1f") m/s")
                }
                
                HStack {
                    Text("Clouds:")
                    Text("\(cityDetails.clouds.all)%")
                }
            }else if let error = error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
            }  else {
                Spacer()
                ProgressView()
                    .onAppear {
                        Task {
                            do {
                                viewModel.cityDetails = try await viewModel.fetchCityDetails(cityName: cityName)
                            } catch {
                                self.error = error
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            }
            Spacer()
            
        }
        .navigationTitle("City Details")
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
