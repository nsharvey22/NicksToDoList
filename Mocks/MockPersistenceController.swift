//
//  MockPersistenceController.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/16/24.
//

import Foundation
import CoreData
import OSLog

final class MockPersistenceController: PersistenceController {
    var persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "NicksToDoList")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = true
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                Logger.log.error("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
