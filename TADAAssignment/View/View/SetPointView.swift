//
//  SetPointView.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit
import CoreLocation

class SetPointView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var btnPointA: UIButton!
    @IBOutlet weak var btnPointB: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var lbPointA: UILabel!
    @IBOutlet weak var lbPointB: UILabel!
    
    var geoData: [GeocodeData] = [GeocodeData]()
  
    var activeIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initView()
    }
    
    private func initView() {
        let bundle = Bundle(for: SetPointView.self)
        bundle.loadNibNamed("SetPointView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        btnPointA.layer.cornerRadius = 20.0
        btnPointA.layer.masksToBounds = true
        btnPointA.backgroundColor = .gray
        
        btnPointB.layer.cornerRadius = 20.0
        btnPointB.layer.masksToBounds = true
        btnPointB.backgroundColor = .gray
        
        btnClear.layer.cornerRadius = 4.0
        btnClear.layer.masksToBounds = true
        btnClear.backgroundColor = .blue
        geoData.removeAll()
    }

    @IBAction func clickClear(_ sender: Any) {
        self.reset()
    }
    
    func setPointValue(locValue: CLLocationCoordinate2D, geoData: GeocodeData) {
        switch activeIndex {
        case 0:
            lbPointA.text = "\(locValue.latitude.rounded(toPlaces: 6).description), \(locValue.longitude.rounded(toPlaces: 6).description)"
            self.appendNewLocation(geoData: geoData)
        case 1:
            lbPointB.text = "\(locValue.latitude.rounded(toPlaces: 6).description), \(locValue.longitude.rounded(toPlaces: 6).description)"
            self.appendNewLocation(geoData: geoData)
        default:
            break
        }
    }
}

extension SetPointView {
    private func appendNewLocation(geoData: GeocodeData) {
        self.geoData.append(geoData)
        activeIndex = activeIndex + 1
        self.setActiveButtons()
    }
    
    func reset() {
        geoData.removeAll()
        lbPointA.text = Globals.MSG_NO_INFORMATION
        lbPointB.text = Globals.MSG_NO_INFORMATION
        activeIndex = 0
        self.setActiveButtons()
    }
    
    private func setActiveButtons() {
        btnPointA.backgroundColor = activeIndex >= 1 ? .blue : .gray
        btnPointB.backgroundColor = activeIndex > 1 ? .blue : .gray
    }
}
