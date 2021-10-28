//
//  SetPointViewTests.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 27/10/2021.
//

import XCTest
import CoreLocation
@testable import TADAAssignment

class SetPointViewTests: XCTestCase {
    var storyboard: UIStoryboard!
    var sut: MainViewController!
    var centerMapCoordinate: CLLocationCoordinate2D!
    
    override func setUp() {
        super.setUp()
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "MainViewController") as? MainViewController
        sut?.loadViewIfNeeded()
        
        let latitude = 12.7789241
        let longitude = 106.6880843
        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    override func tearDown() {
        super.tearDown()
        storyboard = nil
        sut = nil
        centerMapCoordinate = nil
    }
    
    func testSetPointView_WhenCreate_AllIBOutletHaveReference() throws {
        let _ = try XCTUnwrap(sut.viewSetPoint, "Missing viewSetPoint reference")
        let _ = try XCTUnwrap(sut.viewSetPoint.btnPointA, "Missing btnPointA reference")
        let _ = try XCTUnwrap(sut.viewSetPoint.btnPointB, "Missing btnPointB reference")
        let _ = try XCTUnwrap(sut.viewSetPoint.btnClear, "Missing btnClear reference")
        let _ = try XCTUnwrap(sut.viewSetPoint.lbPointA, "Missing lbPointA reference")
        let _ = try XCTUnwrap(sut.viewSetPoint.lbPointB, "Missing lbPointB reference")
        let _ = sut.viewSetPoint.btnPointA
        let _ = sut.viewSetPoint.btnPointB
        let btnClear = sut.viewSetPoint.btnClear
        let _ = sut.viewSetPoint.lbPointA
        let _ = sut.viewSetPoint.lbPointB
        
        let action = btnClear?.actions(forTarget: sut.viewSetPoint, forControlEvent: .touchUpInside)
        XCTAssertEqual(action?.count, 1)
        XCTAssertTrue(action!.contains("clickClear:"))
    }
    
    func testSetPointView_WhenClickButtonClear_InvokeActionReset() throws {
        let button = sut.viewSetPoint.btnClear
        button?.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.viewSetPoint.geoData.count, 0)
        XCTAssertEqual(sut.viewSetPoint.lbPointA.text, Globals.MSG_NO_INFORMATION)
        XCTAssertEqual(sut.viewSetPoint.lbPointB.text, Globals.MSG_NO_INFORMATION)
        XCTAssertEqual(sut.viewSetPoint.activeIndex, 0)
    }
    
    func testSetPointView_WhenSetPointValue_ShouldIncreaseStack() {
        let active = sut.viewSetPoint.activeIndex
        let data = sut.viewSetPoint.geoData
        
        sut.viewSetPoint.setPointValue(locValue: centerMapCoordinate, geoData: GeocodeData())
        XCTAssertEqual(active + 1, sut.viewSetPoint.activeIndex)
        XCTAssertEqual(data.count + 1, sut.viewSetPoint.geoData.count)
        
        sut.viewSetPoint.setPointValue(locValue: centerMapCoordinate, geoData: GeocodeData())
        XCTAssertEqual(active + 2, sut.viewSetPoint.activeIndex)
        XCTAssertEqual(data.count + 2, sut.viewSetPoint.geoData.count)
        
        sut.viewSetPoint.setPointValue(locValue: centerMapCoordinate, geoData: GeocodeData())
        XCTAssertEqual(active + 2, sut.viewSetPoint.activeIndex)
        XCTAssertEqual(data.count + 2, sut.viewSetPoint.geoData.count)
    }
}
