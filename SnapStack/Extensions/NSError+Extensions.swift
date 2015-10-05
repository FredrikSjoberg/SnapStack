//
//  NSError+Extensions.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 05/10/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

extension NSError : LogType {
    public var level: LogLevel {
        return LogLevel.Warning
    }
}