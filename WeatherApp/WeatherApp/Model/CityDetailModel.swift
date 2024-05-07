//
//  CityDetailModel.swift
//  WeatherApp
//
//  Created by Ramamoorthy on 07/05/24.
//


struct CityDetail: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Clouds: Codable {
    let all: Int
}
