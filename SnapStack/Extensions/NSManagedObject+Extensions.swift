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
    internal func inContext<T: NSManagedObject>(context: NSManagedObjectContext) -> T? {
        if self.managedObjectContext === context { return self as? T }
        
        if objectID.temporaryID {
            do {
                try withExtendedLifetime(managedObjectContext) {
                    return try managedObjectContext?.obtainPermanentIDsForObjects([self])
                }
            }
            catch let nsError as NSError {
                print("NSManagedObject.inContext(): \(nsError)") // TODO: Needs to be either logged and/or thrown
                return nil
            }
        }
        
        do {
            return try context.existingObjectWithID(objectID) as? T
        }
        catch let nsError as NSError {
            print("NSManagedObject.inContext(): \(nsError)") // TODO: Needs to be either logged and/or thrown
            return nil
        }
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