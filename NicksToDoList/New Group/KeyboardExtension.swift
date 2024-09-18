//
//  KeyboardExtension.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/16/24.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
