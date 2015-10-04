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
        self.level = level
    }
    
}