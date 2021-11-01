//
//  MainViewControllerTests.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 27/10/2021.
//

import XCTest
@testable import TADAAssignment

class MainViewControllerTests: XCTestCase {

    var initData: ViewControllerInitData!

    override func setUp() {
        super.setUp()
        initData = ViewControllerInitData()
        initData.loadMainViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        initData = nil
    }
    
    func testMainViewController_WhenCreated_IBOutletShouldHaveReference() throws {
        let _ = try XCTUnwrap(initData.sutMainViewController.viewGoogleMap, "Missing viewGoogleMap reference")
        let _ = try XCTUnwrap(initData.sutMainViewController.viewSetPoint, "Missing viewSetPoint reference")
        let _ = try XCTUnwrap(initData.sutMainViewController.viewResult, "Missing viewResult reference")
    }
    
    func testMainViewController_SetPoint() {
        initData.sutMainViewController.viewSetPoint.geoData.removeAll()
        let mock = MockData()
        initData.sutMainViewController.viewSetPoint.geoData.append(mock.geoData)
        initData.sutMainViewController.viewSetPoint.geoData.append(mock.geoData)
        initData.sutMainViewController.viewSetPoint.activeIndex = 2
        initData.sutMainViewController.setMarkerPointInfo(locValue: initData.centerMapCoordinate, geoData: mock.geoData)
    }
    
    func testMainViewController_WhenFinishGetLocationGetGeoCodeInfoFail_ShouldPopupMessage() {
        let expectation = XCTestExpectation(description: "Show Dialog Error")
        let mockMainViewModel = MockMainViewModel()
        initData.sutMainViewController.viewModel = mockMainViewModel
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.initData.sutMainViewController.finishGetLocation(locValue: self.initData.centerMapCoordinate)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                //let className = NSStringFromClass((UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController!.presentedViewController?.classForCoder)!)
                //print("=== \(className)")
                XCTAssertTrue(UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.presentedViewController is UIAlertController)
            })
            
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10)
    }
    
    func testMainViewController_WhenGoToSaveCoordinateList_HistoryControllerShouldShow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            let predicate = NSPredicate { input, _ in
                return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.presentedViewController is HistorySetCoordinateViewController
            }
            self.expectation(for: predicate, evaluatedWith: self.initData.sutMainViewController)
            self.initData.sutMainViewController.gotoHistorySet()
            self.waitForExpectations(timeout: 10)
        })
    }
    
    func testMainViewController_WhenGoToSaveCoordinateList_HistoryControllerShouldShow_V2() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.initData.sutMainViewController.gotoHistorySet()
            
            RunLoop.current.run(until: Date())
            
            guard let _ = (UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController?.presentedViewController) as? HistorySetCoordinateViewController else {
                XCTFail()
                return
            }
        })
    }
    
    func testPushViewControlerWithSpyNavigationController () {
        let spy = SpyNavigationController(rootViewController: initData.sutMainViewController)
        
        // Any action that make push navigation controller
        
        guard let _ = spy.pushViewController as? HistorySetCoordinateViewController else {
            XCTFail()
            return
        }
    }
}
