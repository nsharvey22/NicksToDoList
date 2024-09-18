//
//  ListView.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/15/24.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject private var viewModel: TaskViewModel
    
    var body: some View {
        List {
            ForEach (viewModel.taskItems.filter {
                viewModel.searched.isEmpty ? true : ($0.name?.lowercased() ?? "").contains(viewModel.searched.lowercased())} ){ task in
                    TaskView(taskItem: task)
                }
                .onDelete(perform: {
                    deleteItems(offsets: $0)
                })
        }.listStyle(InsetListStyle())
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            viewModel.removeTaskItem(offsets: offsets)
        }
    }
}

#Preview {
    ListView().environmentObject(TaskViewModel(persistenceController: DefaultPersistenceController.preview))
}
