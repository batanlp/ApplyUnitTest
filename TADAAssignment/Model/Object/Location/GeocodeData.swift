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
    var localityInfo: LocalityInfo?
    init() {
        
    }
}

class LocalityInfo: Codable {
    let administrative: [Administrative]?
    let informative: [Informative]?
}

class Administrative: Codable {
    let order: Int?
    let adminLevel: Int?
    let name: String?
    let description: String?
    let isoName: String?
    let isoCode: String?
    let wikidataId: String?
    let geonameId: Int?
}

class Informative: Codable {
    let order: Int?
    let name: String?
    let description: String?
    let isoCode: String?
    let wikidataId: String?
    let geonameId: Int?
}
