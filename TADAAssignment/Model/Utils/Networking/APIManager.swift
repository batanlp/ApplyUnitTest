//
//  APIManager.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit
import CoreLocation

class APIManager {
    var networking = Networking()
    
    init(networking: Networking = Networking()) {
        self.networking = networking
    }
    
    func requestAPI<T: Codable>(responseObject: T.Type,
                                apiService: ApiServices,
                                completion: ((_ data: T?) -> ())?,
                                errorCompletion: ((_ messages: String?) -> ())?,
                                showLoading: Bool = true) {
        
        if (showLoading) {
            DispatchQueue.main.async {
                LoadingProgress.shared.addLoading()
            }
        }
        
        networking.performNetworkTask(endpoint: apiService, type: BaseResponse<T>.self, completion: { (response) in
            DispatchQueue.main.async {
                if (showLoading) {
                    LoadingProgress.shared.removeLoading()
                }
                completion?(response?.data)
            }
        }) { (errorMessages) in
            DispatchQueue.main.async {
                if (showLoading) {
                    LoadingProgress.shared.removeLoading()
                }
                LogManager.shared.logConsole(msg: errorMessages!)
                errorCompletion?(errorMessages)
            }
        }
    }
}

extension APIManager {
    func getGeocodeInfo(lat: String, long: String, onSuccess: ((_ data: Any?) -> ())?, onError: ((_ messages: String?) -> ())?) {
        networking.performNetworkTask(endpoint: .getGeoCodeInfo(lat, long), type: GeocodeData.self, completion: { (response) in
            DispatchQueue.main.async {
                onSuccess?(response)
            }
        }) { (errorMessages) in
            DispatchQueue.main.async {
                LogManager.shared.logConsole(msg: errorMessages!)
                onError?(errorMessages)
            }
        }
    }
    
    func getAirQuality(locValue: CLLocationCoordinate2D, onSuccess: ((_ data: Any?) -> ())?, onError: ((_ messages: String?) -> ())?) {
        self.requestAPI(responseObject: AirQualityData.self, apiService: .getAirQuality(locValue), completion: { object in
            onSuccess?(object)
        }, errorCompletion: { msg in
            onError?(msg)
        })
    }
}
