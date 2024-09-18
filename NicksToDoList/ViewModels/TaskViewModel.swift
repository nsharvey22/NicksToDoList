//
//  TaskViewModel.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/15/24.
//

import Foundation
import CoreData
import OSLog


final class TaskViewModel: ObservableObject {
    var viewContext: NSManagedObjectContext
    
    @Published var taskItems: [TaskItem] = []
    @Published var sortType : SortType = .alphabetical
    @Published var isPresented = false
    @Published var searched = ""
    
    init(persistenceController: PersistenceController) {
        self.viewContext = persistenceController.persistentContainer.viewContext
        fetchData()
    }
    
    func addTaskItem(taskItem: TaskItem) {
        Logger.log.info("adding item \(String(describing: taskItem.name))")
        taskItems.append(taskItem)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            Logger.log.error("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func removeTaskItem(offsets: IndexSet) {
        Logger.log.info("removing items at \(offsets)")
        offsets.map { taskItems[$0] }.forEach({ taskItem in
            viewContext.delete(taskItem)
        })
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            Logger.log.error("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        fetchData()
    }
    
    func sort(){
        Logger.log.info("sorting tasks")
        switch sortType {
        case .alphabetical :
            Logger.log.info("sorting tasks by alphabetical")
            taskItems.sort(by: { $0.name ?? "" < $1.name ?? "" })
        case .date :
            Logger.log.info("sorting tasks by date")
            taskItems.sort(by: { $0.date ?? Date() > $1.date ?? Date() })
        case .priority :
            Logger.log.info("sorting tasks by priority")
            taskItems.sort(by: { $0.priority ?? "" > $1.priority ?? "" })
        }
    }
    
    func fetchData() {
        Logger.log.info("fetching tasks")
        do {
            let fetchRequest: NSFetchRequest<TaskItem>
            fetchRequest = TaskItem.fetchRequest()
            
            taskItems = try viewContext.fetch(fetchRequest)
        } catch {
            Logger.log.error("Fetch failed: \(error.localizedDescription)")
        }
    }
}
