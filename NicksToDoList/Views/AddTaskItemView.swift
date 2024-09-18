//
//  AddTaskItemView.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/15/24.
//

import SwiftUI

struct AddTaskItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: TaskViewModel
    
    @State var name = ""
    @State var notes = ""
    @State var date = Date()
    @State var priority : Priority = .low
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Task")) {
                    TextField("Name ", text : $name)
                    TextField("Task Notes ", text : $notes)
                }
                Section {
                    Picker("Priority", selection: $priority) {
                        ForEach(Priority.allCases) { priority in
                            Label(
                                title: { Text(priority.title) },
                                icon: { Image(systemName: "exclamationmark.circle") })
                            .foregroundColor(priority.color)
                            .tag(priority)
                        }
                    }
                }
                
                DisclosureGroup("Date") {
                    DatePicker("", selection: $date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                
            }
            .navigationBarTitle("Add", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action:{
                    presentationMode.wrappedValue.dismiss() },
                                label : {
                                    Text("Cancel")
                                        .foregroundColor(.red)
                                }),
                trailing: Button(action:{
                    let newTaskItem = TaskItem(context: viewModel.viewContext)
                    newTaskItem.name = name
                    newTaskItem.notes = notes
                    newTaskItem.date = date
                    newTaskItem.priority = priority.title
                    viewModel.addTaskItem(taskItem: newTaskItem)
                    presentationMode.wrappedValue.dismiss()},
                                 label:{
                                     Text("Save")
                                 }).disabled(name.isEmpty || notes.isEmpty)
            )
        }
    }
}


#Preview {
    AddTaskItemView().environmentObject(TaskViewModel(persistenceController: DefaultPersistenceController.preview))
}
