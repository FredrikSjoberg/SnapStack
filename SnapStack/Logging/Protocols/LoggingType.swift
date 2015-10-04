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
            switch clone.logger!.level {
            case LogLevel.None: clone.logger!.level = .None
            default: clone.logger?.level.insert(level)
            }
        }
        return clone
    }
    
    func log(processor: LogProcessorType) -> Self {
        var clone = self
        if clone.logger == nil {
            clone.logger = processor
        }
        return clone
    }
}