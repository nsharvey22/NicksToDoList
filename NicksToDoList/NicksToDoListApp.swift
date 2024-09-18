//
//  NicksToDoListApp.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/15/24.
//

import SwiftUI

@main
struct NicksToDoListApp: App {
    let persistenceController = DefaultPersistenceController()

    var body: some Scene {
        WindowGroup {
            let viewModel = TaskViewModel(persistenceController: persistenceController)
            ContentView().environmentObject(viewModel)
        }
    }
}
