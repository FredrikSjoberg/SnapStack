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