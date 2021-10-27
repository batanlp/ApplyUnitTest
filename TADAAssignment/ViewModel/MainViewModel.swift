//
//  MainViewModel.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit
import CoreLocation
import CoreData

protocol MainViewModelDelegate: NSObjectProtocol {
    func finishGetLocation(locValue: CLLocationCoordinate2D)
}

class MainViewModel: NSObject {
    weak var delegate: MainViewModelDelegate?
    
    private lazy var coreDataStack = CoreDataStack()
    private lazy var coordinateManager = CDCoordinateManager(
        managedObjectContext: coreDataStack.mainContext,
        coreDataStack: coreDataStack)
    
    let locationManager = CLLocationManager()
    var geoCodeData: GeocodeData?
    
    override init() {
    }
}

extension MainViewModel {
    func getGeocodeInfo(apiManager: APIManager = APIManager(), locValue: CLLocationCoordinate2D, onSuccess: (() -> ())?, onError: ((String?) -> ())?) {
        apiManager.getGeocodeInfo(lat: locValue.latitude.description, long: locValue.longitude.description, onSuccess: { response in
            self.geoCodeData = response as? GeocodeData
            onSuccess?()
        }, onError: { msg in
            onError?(msg)
        })
    }
    
    func getAirQuality(apiManager: APIManager = APIManager(), locValue: CLLocationCoordinate2D, onSuccess: ((_ data: Any?) -> ())?, onError: ((String?) -> ())?) {
        apiManager.getAirQuality(locValue: locValue, onSuccess: { response in
            onSuccess?(response)
        }, onError: { msg in
            onError?(msg)
        })
    }
    
    func saveSearchPoint(locValue: CLLocationCoordinate2D, geoData: GeocodeData) -> CoordinateTADA {
        return coordinateManager.saveCoordinate(locValue: locValue, geoData: geoData)
    }
}

extension MainViewModel: CLLocationManagerDelegate {

    func detectLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    let locValue:CLLocationCoordinate2D = manager.location!.coordinate
                    print("locations = \(locValue.latitude) \(locValue.longitude)")
                }
            }
        }
        else {
            print("aaaaa")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        LogManager.shared.logConsole(msg: "locations = \(locValue.latitude) \(locValue.longitude)")
        self.delegate?.finishGetLocation(locValue: locValue)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
