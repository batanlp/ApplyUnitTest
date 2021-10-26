//
//  CDCoordinateManager.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 14/10/2021.
//

import UIKit
import CoreData
import CoreLocation

class CDCoordinateManager: NSObject {
    
    static let shared = CDCoordinateManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    
    override fileprivate init() {
    }
    
    func saveCoordinate(locValue: CLLocationCoordinate2D, geoData: GeocodeData) {
        context = appDelegate.persistentContainer.viewContext
        let info = CoordinateTADA(context: context)
        info.latitude = locValue.latitude
        info.longitude = locValue.longitude
        info.desc = "\(geoData.locality ?? "") \(geoData.city ?? "")"
        
        do {
            try context.save()
        } catch {
            LogManager.shared.logConsole(msg: "Storing data Failed")
        }
    }
    
    func getCoordinatesList() -> [CoordinateTADA]? {
        context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CoordinateTADA")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            return (result as! [CoordinateTADA]).reversed()
        } catch {
            print("Fetching data Failed")
            return nil
        }
    }
}
