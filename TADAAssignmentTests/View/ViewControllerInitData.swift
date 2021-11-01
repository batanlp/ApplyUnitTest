//
//  ViewControllerInitData.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 28/10/2021.
//

import XCTest
import Foundation
import CoreLocation
@testable import TADAAssignment

class ViewControllerInitData {
    
    var storyboard: UIStoryboard!
    var sutMainViewController: MainViewController!
    var sutHistoryViewcontroller: HistorySetCoordinateViewController!
    var centerMapCoordinate: CLLocationCoordinate2D!
    
    init() {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sutMainViewController = storyboard.instantiateViewController(identifier: "MainViewController") as? MainViewController
        
        sutHistoryViewcontroller = storyboard.instantiateViewController(identifier: "HistorySetCoordinateViewController") as? HistorySetCoordinateViewController
        
        
        let latitude = 12.7789241
        let longitude = 106.6880843
        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func loadMainViewController() {
        sutMainViewController?.loadViewIfNeeded()
    }
    
    func loadHistoryViewController() {
        sutHistoryViewcontroller.loadViewIfNeeded()
    }
}
