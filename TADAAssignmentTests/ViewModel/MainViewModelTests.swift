//
//  MainViewModelTests.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 25/10/2021.
//

import XCTest
import CoreLocation
@testable import TADAAssignment

class MainViewModelTests: XCTestCase {
    
    var sutNetworking: Networking!
    
    var coordinateManager: CDCoordinateManager!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        sutNetworking = Networking(session: urlSession)
        
        coreDataStack = TestCoreDataStack()
        coordinateManager = CDCoordinateManager(
            managedObjectContext: coreDataStack.mainContext,
            coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        sutNetworking = nil
        MockURLProtocol.stub = nil
        MockURLProtocol.error = nil
        
        coordinateManager = nil
        coreDataStack = nil
    }
    
    func testMainViewModel_WhenCallGetGeocodeInfoSuccess_ShouldReturnTrue() {
        let jsonString = "{\"continentCode\":\"EU\"}"
        MockURLProtocol.stub = jsonString.data(using: .utf8)
        let sutAPIManager = APIManager(networking: sutNetworking)
        let sut = MainViewModel(delegate: nil)
        
        let expectation = self.expectation(description: "MainViewModel get Geocode Info success")
        let latitude = 10.7789241
        let longitude = 106.6880843
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        sut.getGeocodeInfo(apiManager: sutAPIManager, locValue: centerMapCoordinate, onSuccess: {
            XCTAssert(true)
            expectation.fulfill()
        }, onError: { msg in
        })

        self.wait(for: [expectation], timeout: 5.0)
    }
    
    func testMainViewModel_WhenCalGetGeocodeInfoFail_ShouldReturnErrorMessage() {
        let jsonString = "{\"continentCode\",\"EU\"}"
        MockURLProtocol.stub = jsonString.data(using: .utf8)
        let sutAPIManager = APIManager(networking: sutNetworking)
        let sut = MainViewModel(delegate: nil)
        
        let expectation = self.expectation(description: "MainViewModel get Geocode Info success")
        let latitude = 10.7789241
        let longitude = 106.6880843
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        sut.getGeocodeInfo(apiManager: sutAPIManager, locValue: centerMapCoordinate, onSuccess: {
           
        }, onError: { msg in
            XCTAssertNotNil(msg)
            expectation.fulfill()
        })
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    func testMainViewModel_WhenGetAirQualitySuccess_ShouldReturnSuccess() {
        let jsonString = "{\"status\": \"ok\", \"data\": {\"aqi\": 25}}"
        MockURLProtocol.stub = jsonString.data(using: .utf8)
        let sutAPIManager = APIManager(networking: sutNetworking)
        let sut = MainViewModel(delegate: nil)
        
        let expectation = self.expectation(description: "MainViewModel get Air Quality success")
        let latitude = 10.7789241
        let longitude = 106.6880843
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        sut.getAirQuality(apiManager: sutAPIManager, locValue: centerMapCoordinate, onSuccess: { data in
            let response = data as! AirQualityData
            XCTAssertGreaterThan(response.aqi!, 0)
            expectation.fulfill()
        }, onError: { msg in
            
        })

        self.wait(for: [expectation], timeout: 5.0)
    }
    
    func testMainViewModel_WhenGetAirQualityFail_ShouldReturnError() {
        let jsonString = "{\"status\": \"ok\" : \"data\": {\"aqi\": 25}}"
        MockURLProtocol.stub = jsonString.data(using: .utf8)
        let sutAPIManager = APIManager(networking: sutNetworking)
        let sut = MainViewModel(delegate: nil)
        
        let expectation = self.expectation(description: "MainViewModel get Air Quality fail")
        let latitude = 10.7789241
        let longitude = 106.6880843
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        sut.getAirQuality(apiManager: sutAPIManager, locValue: centerMapCoordinate, onSuccess: { data in
           
        }, onError: { msg in
            XCTAssertNotNil(msg)
            expectation.fulfill()
        })
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    func testMainViewModel_WhenSaveCoordinate_ShouldReturnSuccess() {
        let latitude = 10.7789241
        let longitude = 106.6880843
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let sut = MainViewModel(delegate: nil)
        let info = sut.saveSearchPoint(locValue: centerMapCoordinate, geoData: GeocodeData())
        
        XCTAssertNotNil(info, "CoordinateTADA should not be nil")
        XCTAssertNotNil(info.latitude, "CoordinateTADA should not be nil")
        XCTAssertNotNil(info.longitude, "CoordinateTADA should not be nil")
    }
    
    func testMainViewModel_WhenUserLocatoinService() {
        
        class FakeLocationManager: CLLocationManager{
            
        }
        class FakeLocationManagerDelegate:NSObject, CLLocationManagerDelegate{
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                let loc = locations.first!
                let mockDelegate = MockMainViewModelDelegate()
                let sut = MainViewModel(delegate: mockDelegate)
                print("mock location is \(loc.coordinate.latitude), \(loc.coordinate.longitude)")
                XCTAssertEqual(loc.coordinate.latitude, 10.7789241)
                sut.delegate?.finishGetLocation(locValue: loc.coordinate)
                XCTAssertTrue(mockDelegate.isCallFinishGetLocation)
            }
        }
        let locationMgr = CLLocationManager()
        var locationHelper = HelperLocationManager(locationManager: locationMgr)
        
        let fakeDelegate = FakeLocationManagerDelegate()
        let fakeLocationManager = FakeLocationManager()
        locationHelper = HelperLocationManager(locationManager: fakeLocationManager)
        locationHelper.locationManager.delegate = fakeDelegate
        ((locationHelper.locationManager.delegate) as! FakeLocationManagerDelegate).locationManager(locationHelper.locationManager, didUpdateLocations:  [CLLocation(latitude: 10.7789241,longitude: 106.6880843)])
    }
}
