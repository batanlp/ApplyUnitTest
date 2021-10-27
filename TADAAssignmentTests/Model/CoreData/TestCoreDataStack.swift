//
//  TestCoreDataStack.swift
//  TADAAssignmentTests
//
//  Created by Nguyen Ba Tan on 26/10/2021.
//

import Foundation
import CoreData
import TADAAssignment

class TestCoreDataStack: CoreDataStack {
    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        // NSInMemoryStoreType: This store type saves data to memory so it isn’t persisted. This is useful for unit testing because the data disappears if the app terminates.
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: CoreDataStack.modelName)
        
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        storeContainer = container
    }
}
