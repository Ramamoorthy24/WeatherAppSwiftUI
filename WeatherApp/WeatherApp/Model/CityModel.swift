//
//  CityModel.swift
//  WeatherApp
//
//  Created by Ramamoorthy on 07/05/24.
//

import Foundation


struct City: Identifiable {
    let id = UUID()
    let name: String
}
struct Country: Identifiable {
    let id = UUID()
    let name: String
    let cities: [City]
}
struct CountryData: Codable {
    let country: String
    let cities: [String]
}
