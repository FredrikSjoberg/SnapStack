//
//  NSManagedObject+Extensions.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 2015-09-17.
//  Copyright © 2015 Fredrik Sjoberg. All rights reserved.
//

import Foundation
import CoreData

public extension NSManagedObject {
    public class func entityName() -> String {
        return  NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}

internal extension NSManagedObject {
    internal func inContext<T: NSManagedObject>(context: NSManagedObjectContext) throws -> T {
        if self.managedObjectContext === context {
            return try castEntity()
        }
        
        do {
            if objectID.temporaryID {
                try withExtendedLifetime(managedObjectContext) {
                    return try managedObjectContext?.obtainPermanentIDsForObjects([self])
                }
            }
            
            let rawEntity = try context.existingObjectWithID(objectID)
            return try rawEntity.castEntity()
        }
        catch let nsError as NSError {
            throw ContextError.CoreDataInternal(nsError: nsError)
        }
    }
    
    internal func castEntity<T: NSManagedObject>() throws -> T {
        guard let typedEntity = self as? T else {
            throw ContextError.CastUnsuccessful(expectedEntity: T.entityName(), actualEntity: entity.name, context: managedObjectContext!)
        }
        return typedEntity
    }
}

public extension NSManagedObject {
    public func deleteFromContext() {
        managedObjectContext?.deleteObject(self)
    }
}

public extension NSManagedObject {
    static func nsExpression(value: NSManagedObject?) -> NSExpression {
        if let actual = value {
            return NSExpression(forConstantValue: actual)
        }
        else {
            return NSExpression(forConstantValue: NSNull())
        }
    }
}