//
//  LogType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 04/10/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public protocol LogType : CustomStringConvertible, CustomDebugStringConvertible {
    var level: LogLevel { get }
    
    var description: String { get }
    var debugDescription: String { get }
}

extension LogType {
    internal var logSeverity: String {
        if LogLevel.None.isSubsetOf(level) {
            return "SnapStack: No Log"
        }
        else if LogLevel.Trace.isSubsetOf(level) {
            return "SnapStack: Trace"
        }
        else if LogLevel.Info.isSubsetOf(level) {
            return "SnapStack: Info"
        }
        else if LogLevel.Warning.isSubsetOf(level) {
            return "SnapStack: Warning"
        }
        else if LogLevel.All.isSubsetOf(level) {
            return "SnapStack: Log All"
        }
        else {
            return "SnapStack: Undefined LogType"
        }
    }
}