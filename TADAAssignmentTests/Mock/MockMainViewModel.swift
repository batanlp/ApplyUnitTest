//
//  MockMainViewModel.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 30/10/2021.
//

import Foundation
import CoreLocation
@testable import TADAAssignment

class MockMainViewModel: MainViewModelProtocol {
    func detectLocation() {
        
    }
    
    func getAirQuality(apiManager: APIManager, locValue: CLLocationCoordinate2D, onSuccess: ((Any?) -> ())?, onError: ((String?) -> ())?) {
        
    }
    
    func getGeocodeData() -> GeocodeData? {
        return nil
    }
    
    func saveSearchPoint(locValue: CLLocationCoordinate2D, geoData: GeocodeData) -> CoordinateTADA {
        let info = CoordinateTADA()
        return info
    }
    
    var needFalse: Bool =  true
    
    func getGeocodeInfo(apiManager: APIManager = APIManager(), locValue: CLLocationCoordinate2D, onSuccess: (() -> ())?, onError: ((String?) -> ())?) {
        onError?("Error")
    }
}
