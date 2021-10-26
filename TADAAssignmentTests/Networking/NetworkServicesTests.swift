//
//  NetworkServicesTests.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 21/10/2021.
//

import XCTest
import CoreLocation
@testable import TADAAssignment

class NetworkServicesTests: XCTestCase {
    
    var sutNetworking: Networking!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        sutNetworking = Networking(session: urlSession)
    }
    
    override func tearDown() {
        sutNetworking = nil
        MockURLProtocol.stub = nil
        MockURLProtocol.error = nil
    }
    
    func testNetworking_WhenURLRequestFail_ShouldReturnErrorMessage() {
        let expectation = self.expectation(description: "Fail request expectation")
        
        MockURLProtocol.error = CustomError.failRequest
        
        sutNetworking.performNetworkTask(endpoint: .getGeoCodeInfo("10.7789241", "106.6880843"), type: GeocodeData.self, completion: { (response) in
            expectation.fulfill()
        }) { (errorMessages) in
            XCTAssertEqual(errorMessages, "Fail request")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    func testNetwork_WhenDataReturnFail_ShouldReturnDataNil() {
        let expectation = self.expectation(description: "Fail request expectation")
        
        let urlSession = MockSession.shared
        
        sutNetworking = Networking(session: urlSession)
        
        sutNetworking.performNetworkTask(endpoint: .getGeoCodeInfo("10.7789241", "106.6880843"), type: GeocodeData.self, completion: { (response) in
        }) { (errorMessages) in
            XCTAssertEqual(errorMessages, "Data error")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    func testNetworking_WhenPerformNetworkTaskSuccess_ReturnSuccess() {
        // Arrange
        let jsonString = "{\"continentCode\":\"Asia\"}"
        
        MockURLProtocol.stub = jsonString.data(using: .utf8)
        let expectation = self.expectation(description: "PerformNetwork Success")
        
        sutNetworking.performNetworkTask(endpoint: .getGeoCodeInfo("10.7789241", "106.6880843"), type: GeocodeData.self, completion: { (response) in
            XCTAssertNotEqual(response?.continentCode, "")
            expectation.fulfill()
        }) { (errorMessages) in
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    func testNetWorking_WhenPerformTaskFailWhenDecode_ReturnUnknowError() {
        // Arrange
        let jsonString = "{\"path\": \"/user\" : \"error\":\"Internal server error\"}"
        MockURLProtocol.stub = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "PerformNetwork with Json Decode fail")
        
        sutNetworking.performNetworkTask(endpoint: .getGeoCodeInfo("10.7789241", "106.6880843"), type: GeocodeData.self, completion: { (response) in
            XCTAssertNil(response?.continentCode)
            expectation.fulfill()
        }) { (errorMessages) in
            XCTAssertEqual(errorMessages, "Unknown Error")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5.0)
    }

    func testGetGeoCodeInfo_WhenReceivedSuccessReponse_ReturnSuccess() {
        // Arrange
        let jsonString = "{\"continentCode\":\"Asia\"}"
        MockURLProtocol.stub = jsonString.data(using: .utf8)
        let sut = APIManager(networking: sutNetworking)
        
        let expectation = self.expectation(description: "Get Geocode information expectation")
        
        sut.getGeocodeInfo(lat: "10.7789241", long: "106.6880843", onSuccess: { data in
            // "{\"status\":\"ok\"}"
            let response = data as! GeocodeData
            XCTAssertNotEqual(response.continentCode, "")
            expectation.fulfill()
        }, onError: { msg in
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetGeoCodeInfo_WhenReceivedErrorReponse_ReturnError() {
        // Arrange
        let jsonString = "{\"path\": \"/user\" : \"error\":\"Internal server error\"}"
        MockURLProtocol.stub = jsonString.data(using: .utf8)
        let sut = APIManager(networking: sutNetworking)
        
        let expectation = self.expectation(description: "Get Geocode information expectation")
        
        sut.getGeocodeInfo(lat: "10.7789241", long: "106.6880843", onSuccess: { data in
        }, onError: { msg in
            XCTAssertEqual(msg, "Unknown Error")
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetAirQuality_WhenReceivedSuccessResponse_ReturnSuccess() {
        // Arrange
        let jsonString = "{\"status\": \"ok\", \"data\": {\"aqi\": 25}}"
        MockURLProtocol.stub = jsonString.data(using: .utf8)
        let sut = APIManager(networking: sutNetworking)
        
        let expectation = self.expectation(description: "Get Geocode information expectation")
        let latitude = 10.7789241
        let longitude = 106.6880843
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        sut.getAirQuality(locValue: centerMapCoordinate, onSuccess: { data in
            let response = data as! AirQualityData
            XCTAssertGreaterThan(response.aqi!, 0)
            expectation.fulfill()
        }, onError: { msg in
            expectation.fulfill()
        })
    
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetAirQuality_WhenReceivedFailResponse_ReturnFail() {
        // Arrange
        let jsonString = "{\"status\": \"ok\" : \"data\": {\"aqi\": 25}}"
        MockURLProtocol.stub = jsonString.data(using: .utf8)
        let sut = APIManager(networking: sutNetworking)
        
        let expectation = self.expectation(description: "Get Geocode information expectation")
        let latitude = 10.7789241
        let longitude = 106.6880843
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        sut.getAirQuality(locValue: centerMapCoordinate, onSuccess: { data in
        }, onError: { msg in
            XCTAssertEqual(msg, "Unknown Error")
            expectation.fulfill()
        })
    
        self.wait(for: [expectation], timeout: 5.0)
    }
}
