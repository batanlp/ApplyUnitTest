//
//  LocationInfoViewTests.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 27/10/2021.
//

import XCTest
@testable import TADAAssignment

class LocationInfoViewTests: XCTestCase {
    var initData: ViewControllerInitData!
    var mockDelegate: MockLocationInfoViewDelegate!
    
    override func setUp() {
        super.setUp()
        initData = ViewControllerInitData()
        initData.loadMainViewController()
        
        mockDelegate = MockLocationInfoViewDelegate()
        initData.sutMainViewController.viewResult.delegate = mockDelegate
    }
    
    override func tearDown() {
        super.tearDown()
        
        initData = nil
        mockDelegate = nil
    }
    
    func testLocationInfoView_WhenCreate_AllIBOutletHaveAction() throws {
        let _ = try XCTUnwrap(initData.sutMainViewController.viewResult, "Missing viewResult reference")
        let _ = try XCTUnwrap(initData.sutMainViewController.viewResult.lbDesc, "Missing lbDesc reference")
        let _ = try XCTUnwrap(initData.sutMainViewController.viewResult.btnBack, "Missing btnBack reference")
        
        let btnBack = initData.sutMainViewController.viewResult.btnBack
        
        let action = btnBack?.actions(forTarget: initData.sutMainViewController.viewResult, forControlEvent: .touchUpInside)
        XCTAssertEqual(action?.count, 1)
        XCTAssertTrue(action!.contains("clickBackButton:"))
    }
    
    func testLocationInfoView_WhenClickButtonBack_InvokeActionWithDelegate() throws {
        let button = initData.sutMainViewController.viewResult.btnBack
        button?.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockDelegate.isBackCall)
    }
    
    func testLocationInfoView_WhenHaveInfo_SetLocationInformation() {
        let airData = AirQualityData()
        let mockData = MockData()
        let geoData = mockData.geoData
        geoData!.latitude = initData.centerMapCoordinate.latitude
        geoData!.longitude = initData.centerMapCoordinate.longitude
        
        airData.aqi = 25
        initData.sutMainViewController.viewResult.setLocationInformation(index: 0, airData: airData, geoData: geoData!)
        
        XCTAssertTrue(initData.sutMainViewController.viewResult.getDescDetail(index: 0).contains("Good"))
        
        airData.aqi = 75
        initData.sutMainViewController.viewResult.setLocationInformation(index: 0, airData: airData, geoData: geoData!)
        XCTAssertTrue(initData.sutMainViewController.viewResult.getDescDetail(index: 0).contains("Moderate"))
        
        airData.aqi = 125
        initData.sutMainViewController.viewResult.setLocationInformation(index: 0, airData: airData, geoData: geoData!)
        
        XCTAssertTrue(initData.sutMainViewController.viewResult.getDescDetail(index: 0).contains("Unhealthy for Sensitive Groups"))
        
        airData.aqi = 175
        initData.sutMainViewController.viewResult.setLocationInformation(index: 0, airData: airData, geoData: geoData!)
        
        XCTAssertTrue(initData.sutMainViewController.viewResult.getDescDetail(index: 0).contains("Unhealthy"))
        
        airData.aqi = 225
        initData.sutMainViewController.viewResult.setLocationInformation(index: 0, airData: airData, geoData: geoData!)
        
        XCTAssertTrue(initData.sutMainViewController.viewResult.getDescDetail(index: 0).contains("Unknown"))
        
        initData.sutMainViewController.viewResult.setFullInformation()
        XCTAssertNotEqual(initData.sutMainViewController.viewResult.lbDesc.text, "")
    }
}
