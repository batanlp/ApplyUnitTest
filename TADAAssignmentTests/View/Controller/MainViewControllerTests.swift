//
//  MainViewControllerTests.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 27/10/2021.
//

import XCTest
@testable import TADAAssignment

class MainViewControllerTests: XCTestCase {

    var initData: ViewControllerInitData!

    override func setUp() {
        super.setUp()
        initData = ViewControllerInitData()
        initData.loadMainViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        initData = nil
    }
    
    func testMainViewController_WhenCreated_IBOutletShouldHaveReference() throws {
        let _ = try XCTUnwrap(initData.sutMainViewController.viewGoogleMap, "Missing viewGoogleMap reference")
        let _ = try XCTUnwrap(initData.sutMainViewController.viewSetPoint, "Missing viewSetPoint reference")
        let _ = try XCTUnwrap(initData.sutMainViewController.viewResult, "Missing viewResult reference")
    }
    
    func testMainViewController_SetPoint() {
        initData.sutMainViewController.viewSetPoint.geoData.removeAll()
        let mock = MockData()
        initData.sutMainViewController.viewSetPoint.geoData.append(mock.geoData)
        initData.sutMainViewController.viewSetPoint.geoData.append(mock.geoData)
        initData.sutMainViewController.viewSetPoint.activeIndex = 2
        initData.sutMainViewController.setMarkerPointInfo(locValue: initData.centerMapCoordinate, geoData: mock.geoData)
    }
}
