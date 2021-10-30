//
//  File.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 29/10/2021.
//

import Foundation
import CoreLocation
@testable import TADAAssignment

class HelperLocationManager: NSObject{
    
    let locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        
        self.locationManager.delegate = self
    }
}

extension HelperLocationManager:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
        print("authorization calling in real helper class")
        switch status {
            
        case CLAuthorizationStatus.notDetermined:
            
            locationManager.requestWhenInUseAuthorization()
            
        case CLAuthorizationStatus.restricted:
            
            print("Restricted Access to location")
            
        case CLAuthorizationStatus.denied:
            
            print("User denied access to location")
            
        case CLAuthorizationStatus.authorizedWhenInUse:
            
            self.locationManager.startUpdatingLocation()
            
        default:
            
            print("default authorization")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("locations calling in real helper class")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("error ----", error)
        
    }
}
