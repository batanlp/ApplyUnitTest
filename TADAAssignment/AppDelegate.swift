//
//  AppDelegate.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 09/10/2021.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(Globals.GoogleMapAPIKey)
        
        return true
    }
}

