//
//  ContextType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 2015-09-19.
//  Copyright © 2015 Fredrik Sjoberg. All rights reserved.
//

import Foundation
import CoreData

public protocol ContextType {
    var handlerContext: NSManagedObjectContext { get }
    
    func seed<T: NSManagedObject>(entity: T.Type) -> Seed<T>
    func fetch<T: NSManagedObject>(entity: T.Type) -> Fetch<T>
    func create<T: NSManagedObject>(entity: T.Type) -> T?
    func edit<T: NSManagedObject>(entity: T?) -> T?
    func delete<T: NSManagedObject>(entity: T)
}

public extension ContextType {
    public func seed<T: NSManagedObject>(entity: T.Type) -> Seed<T> {
        return Seed(context: self)
    }
    
    public func fetch<T: NSManagedObject>(entity: T.Type) -> Fetch<T> {
        return Fetch(context: handlerContext)
    }
    
    public func create<T: NSManagedObject>(entity: T.Type) -> T? {
        return NSEntityDescription.insertNewObjectForEntityForName(entity.entityName(), inManagedObjectContext: handlerContext) as? T
    }
    
    public func edit<T: NSManagedObject>(entity: T?) -> T? {
        return entity?.inContext(handlerContext)
    }
    
    public func delete<T: NSManagedObject>(entity: T) {
        entity.inContext(handlerContext)?.deleteFromContext()
    }
}