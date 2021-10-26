//
//  ApiServices.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import Foundation
import CoreLocation

enum ApiServices {
    case getGeoCodeInfo(String, String)
    case getAirQuality(CLLocationCoordinate2D)
}

extension ApiServices: EndpointType {
    var baseURL: URL {
        switch self {
        case .getGeoCodeInfo(_, _):
            return URL(string: BaseURLRoute.shared.getBaseGeocodeRouteURL())!
        default:
            return URL(string: BaseURLRoute.shared.getBaseAirQualityURL())!
        }
    }
    
    var path: String {
        switch self {
        case .getGeoCodeInfo(let lat, let long):
            return "?latitude=\(lat)&longitude=\(long)&localityLanguage=en"
        case .getAirQuality(let locValue):
            return "\(locValue.latitude.rounded(toPlaces: 6).description);\(locValue.longitude.rounded(toPlaces: 6).description)/?token=\(Globals.AirQualityKey)"
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    var parameters: Dictionary<String, Any> {
        switch self {
        default:
            return [:]
        }
    }
    
    var header_auth: String {
        switch self {
        default:
            return ""
        }
    }
}
