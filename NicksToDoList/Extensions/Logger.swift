//
//  Logger.swift
//  NicksToDoList
//
//  Created by Nick Harvey on 9/17/24.
//

import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let log = Logger(subsystem: subsystem, category: "log")
}
