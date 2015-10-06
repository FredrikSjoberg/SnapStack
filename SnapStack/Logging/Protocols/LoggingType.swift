//
//  LoggingType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 04/10/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public protocol LoggingType {
    var logger: LogProcessorType? { get set }
}

public extension LoggingType {
    func log(level: LogLevel) -> Self {
        var clone = self
        if clone.logger != nil {
            switch (level, clone.logger!.level) {
                // Disable Logging
            case (LogLevel.None, _): clone.logger!.level = .None
            default:
                if level.contains(.None) {
                    // A set that contains .None makes that the only valid option
                    // It ignores any "additional" settings in the set
                    clone.logger!.level = .None
                }
                else {
                    clone.logger?.level.insert(level)
                }
            }
        }
        else {
            clone.logger = LogProcessor(level: level)
        }
        return clone
    }
    
    /// Exchanges the current logger, if any.
    func log(processor: LogProcessorType) -> Self {
        var clone = self
        clone.logger = processor
        return clone
    }
}