//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Ramamoorthy on 07/05/24.
//

import SwiftUI

@available(iOS 14.0, *)
@main
struct WeatherAppApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            WeatherCityListView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

