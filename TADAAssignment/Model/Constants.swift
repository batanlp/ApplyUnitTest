//
//  Constants.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import Foundation

struct Globals {
    
    static let SHOW_LOG = true
    
    static let GoogleMapAPIKey = "AIzaSyAsplIdUCrZ9WxJIqeMHUWMKUS8CCzEs-g"
    static let AirQualityKey = "b969f25033d9f82f0a7a030ebf92bad2f80e1cbc"
    
    // URL
    static let BASE_URL_AIR_QUALITY = "https://api.waqi.info/feed/geo:"
    static let BASE_URL_GEOCODE = "https://api.bigdatacloud.net/data/reverse-geocode-client/"
    
    static let DEFAULT_MAP_ZOOM: Float = 15.0
    
    static let MSG_NO_INFORMATION = "(No information)"
}

enum CustomError: String, Error {
    case failRequest = "Fail Request"
 }
