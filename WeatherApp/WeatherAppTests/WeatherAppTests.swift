//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Ramamoorthy on 07/05/24.
//

import XCTest
@testable import WeatherApp

class CityViewModelTests: XCTestCase {

    var viewModel: CityViewModel!
    var cityDetail: CityDetail?

    override func setUp() {
        super.setUp()
        viewModel = CityViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchCityDetails() {
        // Given
        let cityName = "London"
        let expectation = XCTestExpectation(description: "Fetch city details")

        // When
        Task {
            do {
                cityDetail = try await viewModel.fetchCityDetails(cityName: cityName)
                expectation.fulfill()
            } catch {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }

        // Then
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(cityDetail)
        XCTAssertEqual(cityDetail?.name, "London")
    }
}
