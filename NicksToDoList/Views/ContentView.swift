//
//  ContentView.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/15/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: TaskViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchView().environmentObject(viewModel)
                SortPickerView().environmentObject(viewModel)
                ListView().environmentObject(viewModel)
            }
            .modifier(MainViewModifier())
        }
    }
}

#Preview {
    ContentView().environmentObject(TaskViewModel(persistenceController: DefaultPersistenceController.preview))
}
