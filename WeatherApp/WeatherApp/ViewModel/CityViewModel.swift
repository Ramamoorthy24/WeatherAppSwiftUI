//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Ramamoorthy on 07/05/24.
//

import Foundation

enum FetchError: Error {
    case encodingError
    case invalidURL
    case decodingError
}

class CityViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var cityDetails: CityDetail?
    @Published var isRefreshing = false
    
    func fetchCityList() async {
        do {
            if let path = Bundle.main.path(forResource: "Countries", ofType: "json") {
                let data = try await withCheckedThrowingContinuation { continuation in
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        continuation.resume(returning: data)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
                
                let decoder = JSONDecoder()
                let countriesData = try decoder.decode([CountryData].self, from: data)
                
                DispatchQueue.main.async {
                    for countryData in countriesData {
                        let cities = countryData.cities.map { City(name: $0) }
                        self.countries.append(Country(name: countryData.country, cities: cities))
                    }
                }
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func refreshData() async {
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            await fetchCityList()
        }  catch let error {
            print("Error", error.localizedDescription)
        }

    }
    
    
    func fetchCityDetails(cityName: String) async throws -> CityDetail {
        guard let encodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw FetchError.encodingError
        }
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCityName)&appid=\(weatherAPIKey)") else {
            throw FetchError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            let cityDetail = try decoder.decode(CityDetail.self, from: data)
            return cityDetail
        } catch {
            throw FetchError.decodingError
        }
    }
}
