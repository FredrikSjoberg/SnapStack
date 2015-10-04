//
//  LogLevel.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 04/10/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public struct LogLevel : OptionSetType {
    public let rawValue: Int
    public init(rawValue: Int) { self.rawValue = rawValue }
    
    public static let None = LogLevel(rawValue: 1)
    public static let Trace = LogLevel(rawValue: 2)
    public static let Info = LogLevel(rawValue: 4)
    public static let Warning = LogLevel(rawValue: 8)
    public static let All : LogLevel = [Trace, Info, Warning]
}