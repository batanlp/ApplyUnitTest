//
//  GoogleMapViewTests.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 27/10/2021.
//

import XCTest
import CoreLocation
import GoogleMaps
@testable import TADAAssignment

class GoogleMapViewTests: XCTestCase {
    var initData: ViewControllerInitData!
    var mockDelegate: MockGoogleMapViewDelegate!
    
    override func setUp() {
        super.setUp()
        initData = ViewControllerInitData()
        initData.loadMainViewController()
       
        mockDelegate = MockGoogleMapViewDelegate()
        initData.sutMainViewController.viewGoogleMap.delegate = mockDelegate
    }
    
    override func tearDown() {
        super.tearDown()
        initData = nil
        mockDelegate = nil
    }
    
    func testGoogleMapView_WhenCreate_AllButtonHaveAction() throws {
        let _ = try XCTUnwrap(initData.sutMainViewController.viewGoogleMap, "Missing viewGoogleMap reference")
        
        let btnSet = initData.sutMainViewController.viewGoogleMap.btnSet
        let btnHistory = initData.sutMainViewController.viewGoogleMap.btnHistory
        
        let actionSet = btnSet?.actions(forTarget: initData.sutMainViewController.viewGoogleMap, forControlEvent: .touchUpInside)
        XCTAssertEqual(actionSet?.count, 1)
        XCTAssertTrue(actionSet!.contains("clickBtnSet:"))
        
        let actionHistory = btnHistory?.actions(forTarget: initData.sutMainViewController.viewGoogleMap, forControlEvent: .touchUpInside)
        XCTAssertEqual(actionHistory?.count, 1)
        XCTAssertTrue(actionHistory!.contains("clickBtnHistory:"))
    }
    
    func testGoogleMapView_WhenClickButtonSet_InvokeActionWithDelegate() throws {
        let btnSet = initData.sutMainViewController.viewGoogleMap.btnSet
        btnSet?.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockDelegate.isSetMarkerPointInfoCall)
    }
    
    func testGoolgeMapView_WhenClickButtonHistory_InvokeActionWithDelegate() throws {
        let btnHistory = initData.sutMainViewController.viewGoogleMap.btnHistory
        btnHistory?.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockDelegate.isGotoHistorySetCall)
    }
    
    func testGoogleMapView_WhenUpdateLocation_ShouldMoveToNewCameraView() throws {
        /*
        class MockGMSMapViewDelegate: NSObject, GMSMapViewDelegate {
            func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
                XCTAssertEqual(mapView.camera.target.latitude, 12.7789241)
            }
        }
        let mocDelegate = MockGMSMapViewDelegate()
        initData.sutMainViewController.viewGoogleMap.mapView?.delegate = mocDelegate
 */
        initData.sutMainViewController.viewGoogleMap.updateLocation(locValue: initData.centerMapCoordinate)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            XCTAssertEqual(self.initData.sutMainViewController.viewGoogleMap.mapView?.camera.target.latitude, 12.7789241)
        }
    }
    
    func testGoogleMapview_WhenPutMarker_ShouldHaveMarkerAtLocation() throws {
        initData.sutMainViewController.viewGoogleMap.putMarker(locValue: initData.centerMapCoordinate, info: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            XCTAssertEqual(self.initData.sutMainViewController.viewGoogleMap.mapView?.camera.target.latitude, 12.7789241)
        }
    }
    
    func testGoogleMapView_WhenGetGeocode_ShouldReturnGeocodeData() throws {
        initData.sutMainViewController.viewGoogleMap.geoData = GeocodeData()
        initData.sutMainViewController.viewGoogleMap.geoData?.latitude = 12.7789241
        
        let info = initData.sutMainViewController.viewGoogleMap.getGeocode()
        XCTAssertEqual(info.latitude, 12.7789241)
    }
}
