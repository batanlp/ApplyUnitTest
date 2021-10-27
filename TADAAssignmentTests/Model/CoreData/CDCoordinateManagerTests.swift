//
//  CDCoordinateManagerTests.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 26/10/2021.
//

import XCTest
import CoreData
@testable import TADAAssignment

class CDCoordinateManagerTests: XCTestCase {
    
    var coordinateManager: CDCoordinateManager!
    var coreDataStack: CoreDataStack!

    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        coordinateManager = CDCoordinateManager(
            managedObjectContext: coreDataStack.mainContext,
            coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coordinateManager = nil
        coreDataStack = nil
    }
    
    func testCoordinateManager_WhenSaveCoordinateSucccess_ShouldReturnSuccess() {
        let latitude = 10.7789241
        let longitude = 106.6880843
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let info = coordinateManager.saveCoordinate(locValue: centerMapCoordinate, geoData: GeocodeData())
        
        XCTAssertNotNil(info, "CoordinateTADA should not be nil")
        XCTAssertNotNil(info.latitude, "CoordinateTADA should not be nil")
        XCTAssertNotNil(info.longitude, "CoordinateTADA should not be nil")
    }
    
    func testCoordinateManage_ContextIsSavedWhenAddNewCoordinateAsync_ShouldReturnSuccess() {
        let coordinateContext = coreDataStack.newDerivedContext()
        coordinateManager = CDCoordinateManager(
            managedObjectContext: coordinateContext,
            coreDataStack: coreDataStack)
        
        expectation(
            forNotification: .NSManagedObjectContextDidSave,
            object: coreDataStack.mainContext) { _ in
            return true
        }
        
        coordinateContext.perform {
            let latitude = 10.7789241
            let longitude = 106.6880843
            let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let info = self.coordinateManager.saveCoordinate(locValue: centerMapCoordinate, geoData: GeocodeData())
            
            XCTAssertNotNil(info)
        }
        
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    
    func testCoordinateManager_WhenGetCoordinateListSuccess_ShouldReturnSuccess() {
        let latitude = 10.7789241
        let longitude = 106.6880843
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let info = coordinateManager.saveCoordinate(locValue: centerMapCoordinate, geoData: GeocodeData())
        
        XCTAssertNotNil(info)
        let listCoordinate = coordinateManager.getCoordinatesList()
    
        XCTAssertNotNil(listCoordinate)
        XCTAssertTrue(listCoordinate?.count == 1)
    }
    
    func testCoordinateManager_WhenUpdateCoordinateSuccess_ShouldReturnSuccess() {
        let latitude = 10.7789241
        let longitude = 106.6880843
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let info = coordinateManager.saveCoordinate(locValue: centerMapCoordinate, geoData: GeocodeData())
        
        XCTAssertNotNil(info)
        
        info.latitude = 11.7789241
        
        let updateInfo = coordinateManager.update(info)
        
        XCTAssertNotNil(updateInfo)
        XCTAssertEqual(updateInfo.latitude, 11.7789241)
    }
    
    func testCoordinateManager_WhenDeleteCoordinateSuccess_ShouldReturnSuccess() {
        let latitude = 10.7789241
        let longitude = 106.6880843
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let info = coordinateManager.saveCoordinate(locValue: centerMapCoordinate, geoData: GeocodeData())
        
        XCTAssertNotNil(info)
        
        coordinateManager.delete(info)
        
        let list = coordinateManager.getCoordinatesList()

        XCTAssertTrue(list?.isEmpty ?? false)
    }
}
