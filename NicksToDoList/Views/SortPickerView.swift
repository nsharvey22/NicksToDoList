//
//  SortPickerView.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/15/24.
//

import SwiftUI

struct SortPickerView: View {
    @EnvironmentObject private var viewModel: TaskViewModel
    
    var body: some View {
        Picker("", selection: $viewModel.sortType) {
            ForEach(SortType.allCases){
                Text($0.rawValue.capitalized)
                    .tag($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

#Preview {
    SortPickerView().environmentObject(TaskViewModel(persistenceController: DefaultPersistenceController.preview))
}
