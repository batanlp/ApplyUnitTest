//
//  BaseURLRoute.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit

class BaseURLRoute: NSObject {
    static let shared = BaseURLRoute()
    
    override fileprivate init() {
    }
    
    func getBaseGeocodeRouteURL() -> String {
        return Globals.BASE_URL_GEOCODE
    }
    
    func getBaseAirQualityURL() -> String {
        return Globals.BASE_URL_AIR_QUALITY
    }
}
