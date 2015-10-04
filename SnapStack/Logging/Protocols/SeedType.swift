//
//  SeedType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 04/10/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation
import CoreData

public protocol SeedType {
    typealias Entity: NSManagedObject
    
    var context: ContextType { get }
}