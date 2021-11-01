//
//  SpyNavigationController.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 31/10/2021.
//

import UIKit

class SpyNavigationController: UINavigationController {
    
    var pushViewController: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        pushViewController = viewController
    }
}
