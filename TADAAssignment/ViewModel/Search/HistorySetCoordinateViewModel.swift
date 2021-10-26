//
//  HistorySetCoordinateViewModel.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 14/10/2021.
//

import UIKit
import CoreData

class HistorySetCoordinateViewModel: NSObject {
    
    private lazy var coreDataStack = CoreDataStack()
    private lazy var coordinateManager = CDCoordinateManager(
        managedObjectContext: coreDataStack.mainContext,
        coreDataStack: coreDataStack)
    
    var listCoordinate: [CoordinateTADA] = [CoordinateTADA]()
    
    override init() {
    }
    
    func getTotalCoordinate() -> Int {
        return listCoordinate.count
    }
    
    func getAllCoordinate() {
        self.listCoordinate = self.coordinateManager.getCoordinatesList()!
    }
    
    func getCoordinate(atIndex: Int) -> CoordinateTADA{
        return listCoordinate[atIndex]
    }
}
