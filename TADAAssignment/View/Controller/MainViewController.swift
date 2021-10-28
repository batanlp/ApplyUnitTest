//
//  MainViewController.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit
import CoreLocation

class MainViewController: BaseViewController {
    
    let viewModel = MainViewModel()
    @IBOutlet weak var viewGoogleMap: GoogleMapView!
    @IBOutlet weak var viewSetPoint: SetPointView!
    @IBOutlet weak var viewResult: LocationInfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initValue()
        self.viewModel.delegate = self
        self.viewModel.detectLocation()
    }
}

extension MainViewController {
    private func initValue() {
        viewResult.isHidden = true
        viewResult.delegate = self
        self.viewGoogleMap.delegate = self
    }
    
    private func getAirQuality() {
        let group = DispatchGroup()
        for (index, geoData) in self.viewSetPoint.geoData.enumerated() {
            group.enter()
            
            let latitude = geoData.latitude
            let longitude = geoData.longitude
            let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            
            self.viewModel.getAirQuality(locValue: centerMapCoordinate, onSuccess: { data in
                LogManager.shared.logConsole(msg: "Done get AirQuality for index \(index)")
                self.viewResult.setLocationInformation(index: index, airData: data as! AirQualityData, geoData: self.viewSetPoint.geoData[index])
                group.leave()
            }, onError: { msg in
                
            })
        }
        group.notify(queue: .main, execute: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.viewResult.isHidden = false
                self.viewResult.setFullInformation()
            }
        })
    }
}

extension MainViewController: LocationInfoViewDelegate {
    func back() {
        self.viewResult.isHidden = true
        self.viewSetPoint.reset()
    }
}

extension MainViewController: GoogleMapViewDelegate {
    func didEndDragMap(locValue: CLLocationCoordinate2D) {
        self.finishGetLocation(locValue: locValue)
    }
    
    func setMarkerPointInfo(locValue: CLLocationCoordinate2D, geoData: GeocodeData?) {
        if (self.viewSetPoint.getCurrentActive() == 2) {
            LogManager.shared.logConsole(msg: "To result screen")
            self.getAirQuality()
        }
        else {
            self.viewSetPoint.setPointValue(locValue : locValue, geoData: geoData!)
            _ = self.viewModel.saveSearchPoint(locValue: locValue, geoData: geoData!)
            self.viewGoogleMap.btnHistory.isHidden = false
        }
    }
    
    func gotoHistorySet() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HistorySetCoordinateViewController") as! HistorySetCoordinateViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: HistorySetCoordinateViewControllerDelegate {
    func selectCoordinate(info: CoordinateTADA) {
        let latitude = info.latitude
        let longitude = info.longitude
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.viewGoogleMap.updateLocation(locValue: centerMapCoordinate)
    }
}

extension MainViewController: MainViewModelDelegate {
    func finishGetLocation(locValue: CLLocationCoordinate2D) {
        self.viewGoogleMap.updateLocation(locValue: locValue)
        self.viewModel.getGeocodeInfo(locValue: locValue, onSuccess: {
            self.viewGoogleMap.putMarker(locValue: locValue, info: self.viewModel.geoCodeData!)
        }, onError: { msg in
            PopupDialog.shared.showPopupDialog(vc: self, msg: msg!)
        })
    }
}
