//
//  GeocodeData.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit

class GeocodeData: Codable {
    var latitude: Double? = 0.0
    var longitude: Double? = 0
    var lookupSource: String? = ""
    var plusCode: String?
    var localityLanguageRequested: String? = ""
    var continent: String? = ""
    var continentCode: String? = ""
    var countryName: String? = ""
    var countryCode: String? = ""
    var principalSubdivision: String? = ""
    var principalSubdivisionCode: String? = ""
    var city: String? = ""
    var locality: String? = ""
    var postcode: String? = ""
    var localityInfo: LocalityInfo? = LocalityInfo()
    init() {
        
    }
}

class LocalityInfo: Codable {
    var administrative: [Administrative]? = [Administrative]()
    var informative: [Informative]?
}

class Administrative: Codable {
    var order: Int?
    var adminLevel: Int?
    var name: String?
    var description: String?
    var isoName: String?
    var isoCode: String?
    var wikidataId: String?
    var geonameId: Int?
}

class Informative: Codable {
    let order: Int?
    let name: String?
    let description: String?
    let isoCode: String?
    let wikidataId: String?
    let geonameId: Int?
}
