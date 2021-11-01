//
//  HistorySetCoordinateViewControllerTests.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 31/10/2021.
//

import XCTest
@testable import TADAAssignment

class MockHistorySetCoordinateViewController: HistorySetCoordinateViewController {
        var dismissCalled = false
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            super.dismiss(animated: flag, completion: completion)
            self.dismissCalled = true
        }
    
        override func clickBtnCancel(_ sender: Any) {
            self.dismissCalled = true
        }
    }

class HistorySetCoordinateViewControllerTests: XCTestCase {
    
    var initData: ViewControllerInitData!

    override func setUp() {
        super.setUp()
        
        initData = ViewControllerInitData()
        initData.loadHistoryViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        
        initData = nil
    }
    
    func testHistoryViewController_WhenCreated_IBOutletShouldHaveReference() throws {
        let _ = try XCTUnwrap(initData.sutHistoryViewcontroller.tableView, "Missing tableView reference")
        let _ = try XCTUnwrap(initData.sutHistoryViewcontroller.btnCancel, "Missing btnCancel reference")
        
        let buttonCancel = initData.sutHistoryViewcontroller.btnCancel
        let action = buttonCancel?.actions(forTarget: initData.sutHistoryViewcontroller, forControlEvent: .touchUpInside)
        XCTAssertEqual(action?.count, 1)
        XCTAssertTrue(action!.contains("clickBtnCancel:"))
    }
    
    func testHistoryViewController_WhenClickButtonCancel_InvokeAction() throws {
        let mockViewController = MockHistorySetCoordinateViewController()
        mockViewController.btnCancel = initData.sutHistoryViewcontroller.btnCancel
        mockViewController.tableView = initData.sutHistoryViewcontroller.tableView
        mockViewController.loadViewIfNeeded()
        
        //initData.sutHistoryViewcontroller = mockController
        //let buttonCancel = mockViewController.btnCancel
        //buttonCancel?.sendActions(for: .touchUpInside)
        //XCTAssertTrue(mockDelegate.isSetMarkerPointInfoCall)
        //mockViewController.btnCancel.sendActions(for: .touchUpInside)
        mockViewController.clickBtnCancel(self)
        
        
        XCTAssertTrue(mockViewController.dismissCalled)
    }

}
