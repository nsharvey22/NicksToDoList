//
//  NicksToDoListTests.swift
//  NicksToDoListTests
//
//  Created by Nick Harvey on 9/15/24.
//

import XCTest
@testable import NicksToDoList


final class TaskViewModelTests: XCTestCase {
    var viewModel: TaskViewModel!
    var persistenceController: MockPersistenceController!
    

    override func setUpWithError() throws {
        persistenceController = MockPersistenceController()
        viewModel = TaskViewModel(persistenceController: persistenceController)
    }

    override func tearDownWithError() throws {
        persistenceController = nil
        viewModel = nil
    }

    func test_addTaskItem_didAddDefaultTask() {
        //Arrange
        let taskItem = TaskItem(context: viewModel.viewContext)
        //Act
        viewModel.addTaskItem(taskItem: taskItem)
        //Assert
        XCTAssertEqual(viewModel.taskItems.count, 1)
    }
    
    func test_addTaskItem_didAddTaskAndChangeName() {
        //Arrange
        let taskItem = TaskItem(context: viewModel.viewContext)
        //Act
        taskItem.name = "New Task Name"
        viewModel.addTaskItem(taskItem: taskItem)
        //Assert
        XCTAssertEqual(viewModel.taskItems.count, 1)
        XCTAssertEqual(viewModel.taskItems.first?.name, "New Task Name")
    }
    
    
    func test_addTaskItem_didAddMultipleTasks() {
        //Arrange
        for _ in 0..<3 {
            let taskItem = TaskItem(context: viewModel.viewContext)
            //Act
            viewModel.addTaskItem(taskItem: taskItem)
        }
        //Assert
        XCTAssertEqual(viewModel.taskItems.count, 3)
    }
    
    func test_removeTaskItem_didDeleteFirstTask() {
        //Arrange
        for _ in 0..<3 {
            let taskItem = TaskItem(context: viewModel.viewContext)
            viewModel.addTaskItem(taskItem: taskItem)
        }
        //Act
        viewModel.removeTaskItem(offsets: [0])
        //Assert
        XCTAssertEqual(viewModel.taskItems.count, 2)
    }
    
    func test_removeTaskItem_didDeleteAllTasks() {
        //Arrange
        for _ in 0..<3 {
            let taskItem = TaskItem(context: viewModel.viewContext)
            viewModel.addTaskItem(taskItem: taskItem)
        }
        //Act
        for _ in 0..<3 {
            viewModel.removeTaskItem(offsets: [0])
        }
        
        //Assert
        XCTAssertEqual(viewModel.taskItems.count, 0)
    }
    
    func test_sort_didSortAlphabetically() {
        //Arrange
        let taskItem1 = TaskItem(context: viewModel.viewContext)
        let taskItem2 = TaskItem(context: viewModel.viewContext)
        let taskItem3 = TaskItem(context: viewModel.viewContext)
        
        taskItem1.name = "ATask"
        taskItem2.name = "BTask"
        taskItem3.name = "CTask"
        //Act
        viewModel.addTaskItem(taskItem: taskItem1)
        viewModel.addTaskItem(taskItem: taskItem2)
        viewModel.addTaskItem(taskItem: taskItem3)
        //Assert
        XCTAssertEqual(viewModel.taskItems[0].name, "ATask")
        XCTAssertEqual(viewModel.taskItems[1].name, "BTask")
        XCTAssertEqual(viewModel.taskItems[2].name, "CTask")
    }

}
