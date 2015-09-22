//
//  Fetch.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 21/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation
import CoreData

public struct Fetch<T: NSManagedObject> {
    public typealias Entity = T
    
    public var predicate: NSPredicate?
    public var sortDescriptors: [NSSortDescriptor]?
    public let context: NSManagedObjectContext
    public let entityName: String
    
    public init(context: NSManagedObjectContext) {
        self.context = context
        self.entityName = T.entityName()
        predicate = nil
        sortDescriptors = nil
    }
}

extension Fetch : FetchType { }