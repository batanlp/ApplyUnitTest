//
//  GoogleMapView.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit
import GoogleMaps

protocol GoogleMapViewDelegate: NSObjectProtocol {
    func didEndDragMap(locValue: CLLocationCoordinate2D)
    func setMarkerPointInfo(locValue: CLLocationCoordinate2D, geoData: GeocodeData?)
    func gotoHistorySet()
}

class GoogleMapView: UIView {
    weak var delegate: GoogleMapViewDelegate?
    
    private lazy var coreDataStack = CoreDataStack()
    private lazy var coordinateManager = CDCoordinateManager(
        managedObjectContext: coreDataStack.mainContext,
        coreDataStack: coreDataStack)
    
    @IBOutlet var contentView: UIView!
    var mapView: GMSMapView?
    var marker = GMSMarker()
    var geoData: GeocodeData?
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnSet: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initView()
    }
    
    private func initView() {
        let bundle = Bundle(for: GoogleMapView.self)
        bundle.loadNibNamed("GoogleMapView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: Globals.DEFAULT_MAP_ZOOM)
        mapView = GMSMapView.map(withFrame: self.frame, camera: camera)
        viewMain.addSubview(mapView!)
        
        mapView?.delegate = self
        
        btnSet.layer.cornerRadius = 30.0
        btnSet.layer.masksToBounds = true
        btnSet.backgroundColor = .blue
        
        btnHistory.isHidden = self.isHiddenHistory()
    }
    
    @IBAction func clickBtnSet(_ sender: Any) {
        self.delegate?.setMarkerPointInfo(locValue: self.mapView!.camera.target, geoData: self.geoData)
    }
    
    @IBAction func clickBtnHistory(_ sender: Any) {
        self.delegate?.gotoHistorySet()
    }
    
    private func isHiddenHistory() -> Bool {
        let list = coordinateManager.getCoordinatesList()
        return (list == nil || list?.count == 0)
    }
    
}

extension GoogleMapView {
    func updateLocation(locValue: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: Globals.DEFAULT_MAP_ZOOM)
        mapView?.animate(to: camera)
    }
    
    func putMarker(locValue: CLLocationCoordinate2D, info: GeocodeData?) {
        self.geoData = info
        marker.map = nil
        marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        marker.title = "\(info?.locality ?? "") \(info?.city ?? "")"
        marker.snippet = info?.countryName
        marker.map = mapView
    }
    
    func getGeocode() -> GeocodeData {
        return self.geoData!
    }
}

extension GoogleMapView: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        LogManager.shared.logConsole(msg: "Move to location: \(centerMapCoordinate.latitude) \(centerMapCoordinate.longitude)")
        self.delegate?.didEndDragMap(locValue: centerMapCoordinate)
    }
}
