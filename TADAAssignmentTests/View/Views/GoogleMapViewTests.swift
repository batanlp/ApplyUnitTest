//
//  GoogleMapViewTests.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 27/10/2021.
//

import XCTest
import CoreLocation
@testable import TADAAssignment

class GoogleMapViewTests: XCTestCase {
    var storyboard: UIStoryboard!
    var sut: MainViewController!
    var mockDelegate: MockGoogleMapViewDelegate!
    var centerMapCoordinate: CLLocationCoordinate2D!
    
    override func setUp() {
        super.setUp()
        
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "MainViewController") as? MainViewController
        sut?.loadViewIfNeeded()
        
        let latitude = 12.7789241
        let longitude = 106.6880843
        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        mockDelegate = MockGoogleMapViewDelegate()
        sut.viewGoogleMap.delegate = mockDelegate
    }
    
    override func tearDown() {
        super.tearDown()
        storyboard = nil
        sut = nil
        mockDelegate = nil
        centerMapCoordinate = nil
    }
    
    func testGoogleMapView_WhenCreate_AllButtonHaveAction() throws {
        let _ = try XCTUnwrap(sut.viewGoogleMap, "Missing viewGoogleMap reference")
        
        let btnSet = sut.viewGoogleMap.btnSet
        let btnHistory = sut.viewGoogleMap.btnHistory
        
        let actionSet = btnSet?.actions(forTarget: sut.viewGoogleMap, forControlEvent: .touchUpInside)
        XCTAssertEqual(actionSet?.count, 1)
        XCTAssertTrue(actionSet!.contains("clickBtnSet:"))
        
        let actionHistory = btnHistory?.actions(forTarget: sut.viewGoogleMap, forControlEvent: .touchUpInside)
        XCTAssertEqual(actionHistory?.count, 1)
        XCTAssertTrue(actionHistory!.contains("clickBtnHistory:"))
    }
    
    func testGoogleMapView_WhenClickButtonSet_InvokeActionWithDelegate() throws {
        let btnSet = sut.viewGoogleMap.btnSet
        btnSet?.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockDelegate.isSetMarkerPointInfoCall)
    }
    
    func testGoolgeMapView_WhenClickButtonHistory_InvokeActionWithDelegate() throws {
        let btnHistory = sut.viewGoogleMap.btnHistory
        btnHistory?.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockDelegate.isGotoHistorySetCall)
    }
    
    func testGoogleMapView_WhenUpdateLocation_ShouldMoveToNewCameraView() throws {
        sut.viewGoogleMap.updateLocation(locValue: centerMapCoordinate)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            XCTAssertEqual(self.sut.viewGoogleMap.mapView?.camera.target.latitude, 12.7789241)
        }
    }
    
    func testGoogleMapview_WhenPutMarker_ShouldHaveMarkerAtLocation() throws{
        sut.viewGoogleMap.putMarker(locValue: centerMapCoordinate, info: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            XCTAssertEqual(self.sut.viewGoogleMap.mapView?.camera.target.latitude, 12.7789241)
        }
    }
    
    func testGoogleMapView_WhenGetGeocode_ShouldReturnGeocodeData() throws {
        sut.viewGoogleMap.geoData = GeocodeData()
        sut.viewGoogleMap.geoData?.latitude = 12.7789241
        
        let info = sut.viewGoogleMap.getGeocode()
        XCTAssertEqual(info.latitude, 12.7789241)
    }
}
