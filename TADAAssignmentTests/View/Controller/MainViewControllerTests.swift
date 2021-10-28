//
//  MainViewControllerTests.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 27/10/2021.
//

import XCTest
@testable import TADAAssignment

class MainViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut: MainViewController!

    override func setUp() {
        super.setUp()
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "MainViewController") as? MainViewController
        sut?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        storyboard = nil
        sut = nil
    }
    
    func testMainViewController_WhenCreated_IBOutletShouldHaveReference() throws {
        let _ = try XCTUnwrap(sut.viewGoogleMap, "Missing viewGoogleMap reference")
        let _ = try XCTUnwrap(sut.viewSetPoint, "Missing viewSetPoint reference")
        let _ = try XCTUnwrap(sut.viewResult, "Missing viewResult reference")
    }
}
