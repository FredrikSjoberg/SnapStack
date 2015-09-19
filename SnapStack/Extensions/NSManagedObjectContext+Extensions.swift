//
//  NSManagedObjectContext+Extensions.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 19/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext : ContextType {
    public var handlerContext: NSManagedObjectContext {
        return self
    }
}