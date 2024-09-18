//
//  Priority+SortType.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/15/24.
//

import SwiftUI

enum Priority: Int, Identifiable, CaseIterable, Codable {
    var id: Int { rawValue }
    
    case low
    case medium
    case high
    
    var title: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    var color : Color {
        switch self {
        case .low:
            return .white
        case .medium:
            return .orange
        case .high :
            return .red
        }
    }
}

public enum SortType : String , Identifiable , CaseIterable {
    
    public var id : String { rawValue }
    
    case alphabetical
    case date
    case priority
    
}
