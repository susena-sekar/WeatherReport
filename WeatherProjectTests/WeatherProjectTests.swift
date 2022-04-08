//
//  WeatherProjectTests.swift
//  WeatherProjectTests
//
//  Created by Susena on 06/04/22.
//

import XCTest
@testable import WeatherProject

class WeatherProjectTests: XCTestCase {

    func testApiCall() throws {
      
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=522db6a157a748e2996212343221502&q=Chennai&days=7&aqi=no&alerts=no"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Completion handler invoked")
        var responseError: Error?
        var statusCode = 0

      
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if data != nil {
                promise.fulfill()
                statusCode = 200
            }
            responseError = error
        }
        
      dataTask.resume()
        
      wait(for: [promise], timeout: 5)

      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }
    
    
    func testHaveCity() throws {
        let model = WeatherModel()
        XCTAssertTrue(!model.city.isEmpty)
    }
    
    func testDateConversionWorkingProperly() throws {
        let model = WeatherModel()
        let resultDate1 = "Wednesday, Apr 6, 2022   7:00 PM"
        let resultDate2 = "Wednesday, Apr 6, 2022"
        
        XCTAssertEqual(resultDate1, model.getCurrentDateToShow(dateString: "2022-04-06 19:00"))
        
        XCTAssertEqual(resultDate2, model.getDateToShow(dateString: "2022-04-06"))
    }
}

