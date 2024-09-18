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

    func test_addTaskItem_didAddDefaultTaskSuccessfully() throws {
        //Given
        XCTAssertEqual(viewModel.taskItems.count, 0)
        let taskItem = TaskItem(context: viewModel.viewContext)
        //When
        viewModel.addTaskItem(taskItem: taskItem)
        //Then
        XCTAssertEqual(viewModel.taskItems.count, 1)
    }
    
    func test_addTaskItem_didAddTaskAndChangeName() throws {
        //Given
        XCTAssertEqual(viewModel.taskItems.count, 0)
        let taskItem = TaskItem(context: viewModel.viewContext)
        //When
        taskItem.name = "New Task Name"
        viewModel.addTaskItem(taskItem: taskItem)
        //Then
        XCTAssertEqual(viewModel.taskItems.count, 1)
        XCTAssertEqual(viewModel.taskItems.first?.name, taskItem.name)
    }

}
