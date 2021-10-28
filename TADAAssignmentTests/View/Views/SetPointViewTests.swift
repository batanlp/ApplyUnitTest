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
    
    func testSetPointView_WhenCreate_AllIBOutletHaveReference() throws {
        let _ = try XCTUnwrap(initData.sutMainViewController.viewSetPoint, "Missing viewSetPoint reference")
        let _ = try XCTUnwrap(initData.sutMainViewController.viewSetPoint.btnPointA, "Missing btnPointA reference")
        let _ = try XCTUnwrap(initData.sutMainViewController.viewSetPoint.btnPointB, "Missing btnPointB reference")
        let _ = try XCTUnwrap(initData.sutMainViewController.viewSetPoint.btnClear, "Missing btnClear reference")
        let _ = try XCTUnwrap(initData.sutMainViewController.viewSetPoint.lbPointA, "Missing lbPointA reference")
        let _ = try XCTUnwrap(initData.sutMainViewController.viewSetPoint.lbPointB, "Missing lbPointB reference")
        let _ = initData.sutMainViewController.viewSetPoint.btnPointA
        let _ = initData.sutMainViewController.viewSetPoint.btnPointB
        let btnClear = initData.sutMainViewController.viewSetPoint.btnClear
        let _ = initData.sutMainViewController.viewSetPoint.lbPointA
        let _ = initData.sutMainViewController.viewSetPoint.lbPointB
        
        let action = btnClear?.actions(forTarget: initData.sutMainViewController.viewSetPoint, forControlEvent: .touchUpInside)
        XCTAssertEqual(action?.count, 1)
        XCTAssertTrue(action!.contains("clickClear:"))
    }
    
    func testSetPointView_WhenClickButtonClear_InvokeActionReset() throws {
        let button = initData.sutMainViewController.viewSetPoint.btnClear
        button?.sendActions(for: .touchUpInside)
        XCTAssertEqual(initData.sutMainViewController.viewSetPoint.geoData.count, 0)
        XCTAssertEqual(initData.sutMainViewController.viewSetPoint.lbPointA.text, Globals.MSG_NO_INFORMATION)
        XCTAssertEqual(initData.sutMainViewController.viewSetPoint.lbPointB.text, Globals.MSG_NO_INFORMATION)
        XCTAssertEqual(initData.sutMainViewController.viewSetPoint.activeIndex, 0)
    }
    
    func testSetPointView_WhenSetPointValue_ShouldIncreaseStack() {
        let active = initData.sutMainViewController.viewSetPoint.activeIndex
        let data = initData.sutMainViewController.viewSetPoint.geoData
        
        initData.sutMainViewController.viewSetPoint.setPointValue(locValue: initData.centerMapCoordinate, geoData: GeocodeData())
        XCTAssertEqual(active + 1, initData.sutMainViewController.viewSetPoint.activeIndex)
        XCTAssertEqual(data.count + 1, initData.sutMainViewController.viewSetPoint.geoData.count)
        
        initData.sutMainViewController.viewSetPoint.setPointValue(locValue: initData.centerMapCoordinate, geoData: GeocodeData())
        XCTAssertEqual(active + 2, initData.sutMainViewController.viewSetPoint.activeIndex)
        XCTAssertEqual(data.count + 2, initData.sutMainViewController.viewSetPoint.geoData.count)
        
        initData.sutMainViewController.viewSetPoint.setPointValue(locValue: initData.centerMapCoordinate, geoData: GeocodeData())
        XCTAssertEqual(active + 2, initData.sutMainViewController.viewSetPoint.activeIndex)
        XCTAssertEqual(data.count + 2, initData.sutMainViewController.viewSetPoint.geoData.count)
    }
}
