//
//  MockGoogleMapViewDelegate.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 28/10/2021.
//

import Foundation
import CoreLocation
@testable import TADAAssignment

class MockGoogleMapViewDelegate: NSObject, GoogleMapViewDelegate {
    var isSetMarkerPointInfoCall: Bool = false
    var isDidEndDragMapCall: Bool = false
    var isGotoHistorySetCall: Bool = false
    
    func didEndDragMap(locValue: CLLocationCoordinate2D) {
        isDidEndDragMapCall = true
    }
    
    func setMarkerPointInfo(locValue: CLLocationCoordinate2D, geoData: GeocodeData?) {
        isSetMarkerPointInfoCall = true
    }
    
    func gotoHistorySet() {
        isGotoHistorySetCall = true
    }
}

class MockLocationInfoViewDelegate: NSObject, LocationInfoViewDelegate {
    var isBackCall: Bool = false
    
    func back() {
        isBackCall = true
    }
}
