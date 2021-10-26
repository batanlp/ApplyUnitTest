//
//  GeocodeData.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import UIKit

class GeocodeData: Codable {
    let latitude: Double?
    let longitude: Double?
    let lookupSource: String?
    let plusCode: String?
    let localityLanguageRequested: String?
    let continent: String?
    let continentCode: String?
    let countryName: String?
    let countryCode: String?
    let principalSubdivision: String?
    let principalSubdivisionCode: String?
    let city: String?
    let locality: String?
    let postcode: String?
    let localityInfo: LocalityInfo?
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
