//
//  TaskView.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/15/24.
//

import SwiftUI

struct TaskView: View {
    
    var taskItem : TaskItem
    
    var body: some View {
        VStack (alignment : .leading){
            HStack{
                VStack(alignment:.leading) {
                    Text("Name:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(taskItem.name ?? "")
                        .font(.system(size: 20, weight: .bold))
                }
                Spacer()
                VStack (alignment:.leading){
                    Text("Date:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(taskItem.date ?? Date() , style: .date)
                }
            }
            Text("Priority: \(taskItem.priority ?? "")")
            Text("Notes:")
                .font(.caption)
                .foregroundColor(.secondary)
            Text(taskItem.notes ?? "")
                .font(.system(size: 15, weight: .bold))
                .italic()
        }
        .padding(10)
        .background(
            .white.opacity(0.2))
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10 , style: .continuous)
                .stroke(.white , lineWidth: 0.7)
                .shadow(color: .white, radius: 0.7))
    }
}

#Preview {
    TaskView(taskItem: TaskItem(context: DefaultPersistenceController.preview.persistentContainer.viewContext))
}
