//
//  LogProcessorType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 04/10/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public protocol LogProcessorType {
    var level: LogLevel { get set }
    
    init(level: LogLevel)
}

public extension LogProcessorType {
    func deliver(log: LogType) {
        guard !level.isSubsetOf(LogLevel.None) else { return }
        guard level.contains(log.level) else { return }
        #if DEBUG
            debugPrint("\(log.logSeverity) \(log)")
        #endif
    }
}