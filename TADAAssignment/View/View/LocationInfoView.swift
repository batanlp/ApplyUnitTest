//
//  LocationInfoView.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit

protocol LocationInfoViewDelegate: NSObjectProtocol {
    func back()
}

class LocationInfoView: UIView {
    
    weak var delegate: LocationInfoViewDelegate?
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    private var locationDetailText: [String] = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initView()
    }
    
    private func initView() {
        let bundle = Bundle(for: LocationInfoView.self)
        bundle.loadNibNamed("LocationInfoView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        btnBack.layer.cornerRadius = 12.0
        btnBack.layer.masksToBounds = true
        btnBack.backgroundColor = .blue
        
        locationDetailText.append("")
        locationDetailText.append("")
    }
    
    @IBAction func clickBackButton(_ sender: Any) {
        self.delegate?.back()
    }
    
    func setLocationInformation(index: Int, airData: AirQualityData, geoData: GeocodeData) {
        let point = index == 0 ? "A" : "B"
        locationDetailText[index] = "Information for point \(point):\n"
        locationDetailText[index] = locationDetailText[index] + "Coordinate: \(geoData.latitude!.rounded(toPlaces: 6).description), \(geoData.longitude!.rounded(toPlaces: 6).description)\n"
        
    
        locationDetailText[index] = locationDetailText[index] + "Location: "
        for administrative in geoData.localityInfo!.administrative!.reversed() {
            locationDetailText[index] = locationDetailText[index] + "\(administrative.name!) "
        }
        locationDetailText[index] = locationDetailText[index] + "\n"
        
        locationDetailText[index] = locationDetailText[index] + "Air Quality: "
        switch airData.aqi! {
        case 0...50:
            locationDetailText[index] = locationDetailText[index] + "Good"
        case 51...100:
            locationDetailText[index] = locationDetailText[index] + "Moderate"
        case 101...150:
            locationDetailText[index] = locationDetailText[index] + "Unhealthy for Sensitive Groups"
        case 151...200:
            locationDetailText[index] = locationDetailText[index] + "Unhealthy"
        default:
            locationDetailText[index] = locationDetailText[index] + "Unknown"
        }
    }
    
    func getDescDetail(index: Int) -> String {
        return locationDetailText[index]
    }
    
    func setFullInformation() {
        self.lbDesc.text = "\(locationDetailText[0])\n\n\(locationDetailText[1])"
    }
}
