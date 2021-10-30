//
//  MockData.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 28/10/2021.
//

import Foundation
import CoreData
@testable import TADAAssignment

class MockData {
    var geoData: GeocodeData!
    init() {
        geoData = GeocodeData()
        geoData.latitude = 10.0
        geoData.longitude = 106.0
        
        let administrative = Administrative()
        administrative.name = "HCM"
        geoData.localityInfo?.administrative?.append(administrative)
    }
}

enum MyError: Error {
    case runtimeError(String)
}

class MockNSManagedObjectContext: NSManagedObjectContext {
    override func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any] {
        throw MyError.runtimeError("Error")
    }
}
