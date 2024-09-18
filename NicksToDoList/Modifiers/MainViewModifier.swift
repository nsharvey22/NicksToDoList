//
//  MainViewModifier.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/16/24.
//

import SwiftUI

struct MainViewModifier : ViewModifier {
    
    @EnvironmentObject private var viewModel: TaskViewModel
    
    func body(content : Content) -> some View {
        
        content
            .navigationBarTitle("My Tasks")
            .navigationBarItems(trailing: HStack(spacing:30){
                EditButton()
                    .disabled(viewModel.taskItems.isEmpty)
                Button(
                    action : { viewModel.isPresented.toggle()},
                    label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    })
            })
            .onChange(of: viewModel.sortType, ({
                guard !viewModel.taskItems.isEmpty else { return }
                withAnimation() {viewModel.sort()}
            }))
            .fullScreenCover(isPresented: $viewModel.isPresented, content: {
                AddTaskItemView().environmentObject(viewModel)
            })
    }
    
}
