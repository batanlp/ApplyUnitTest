//
//  MockData.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 28/10/2021.
//

import Foundation
@testable import TADAAssignment

class MockData {
    var geoData: GeocodeData!
    init() {
        geoData = GeocodeData()
        geoData.longitude = 10.0
        geoData.longitude = 106.0
        
        let administrative = Administrative()
        administrative.name = "HCM"
        geoData.localityInfo?.administrative?.append(administrative)
    }
}
