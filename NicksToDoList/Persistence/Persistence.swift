//
//  Persistence.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/15/24.
//

import CoreData
import OSLog

public protocol PersistenceController {
    var persistentContainer: NSPersistentContainer { get }
}

struct DefaultPersistenceController: PersistenceController {
    
    static var preview: DefaultPersistenceController = {
        let result = DefaultPersistenceController(inMemory: true)
        let viewContext = result.persistentContainer.viewContext
        for i in 0..<5 {
            let newTaskItem = TaskItem(context: viewContext)
            newTaskItem.date = Date()
            newTaskItem.name = "Task \(i)"
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            Logger.log.error("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "NicksToDoList")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                Logger.log.error("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
}
