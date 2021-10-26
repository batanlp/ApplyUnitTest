//
//  LogManager.swift
//  TADAAssignment
//
//  Created by Nguyen Ba Tan on 11/10/2021.
//

import Foundation

class LogManager: NSObject {
    static let shared = LogManager()
    override fileprivate init() {
    }
    
    func logConsole(msg: String) {
        if (Globals.SHOW_LOG) {
            print(msg)
        }
    }
}
