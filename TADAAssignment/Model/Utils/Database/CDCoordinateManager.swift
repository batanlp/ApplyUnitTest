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
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    func saveCoordinate(locValue: CLLocationCoordinate2D, geoData: GeocodeData) -> CoordinateTADA {
        let info = CoordinateTADA(context: managedObjectContext)
        info.latitude = locValue.latitude
        info.longitude = locValue.longitude
        info.desc = "\(geoData.locality ?? "") \(geoData.city ?? "")"
        
        coreDataStack.saveContext(managedObjectContext)
        return info
    }
    
    func getCoordinatesList() -> [CoordinateTADA]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CoordinateTADA")
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedObjectContext.fetch(request)
            return (result as! [CoordinateTADA]).reversed()
        } catch {
            print("Fetching data Failed")
            return nil
        }
    }
    
    func update(_ coordinate: CoordinateTADA) -> CoordinateTADA {
      coreDataStack.saveContext(managedObjectContext)
      return coordinate
    }

    func delete(_ coordinate: CoordinateTADA) {
      managedObjectContext.delete(coordinate)
      coreDataStack.saveContext(managedObjectContext)
    }
}
