//
//  Seed.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 04/10/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation
import CoreData

public struct Seed<E: NSManagedObject> : SeedType {
    public typealias Entity = E
    
    public let context: ContextType
    
    // ProgressReportingType
    public var progress: NSProgress
    // LogProcessorType
    public var logger: LogProcessorType?
    
    public init(context: ContextType) {
        self.context = context
        progress = NSProgress(totalUnitCount: -1)
    }
}