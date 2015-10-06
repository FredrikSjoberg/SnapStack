//
//  LogProcessor.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 04/10/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public struct LogProcessor : LogProcessorType {
    public var level: LogLevel
    
    public init(level: LogLevel) {
        if level.contains(.None) {
            // A set that contains .None makes that the only valid option
            // It ignores any "additional" settings in the set
            self.level = .None
        }
        else {
            self.level = level
        }
    }
}