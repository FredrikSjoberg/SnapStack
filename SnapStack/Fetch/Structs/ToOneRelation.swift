//
//  ToOneRelation.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 22/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation
import CoreData

public struct ToOneRelationship<T: NSManagedObject> {
    public typealias Entity = T
    
    public let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public init(keys: [String]) {
        self.init(key: keys.joinWithSeparator("."))
    }
}

extension ToOneRelationship : ToOneRelationType { }

public func ==<Entity: NSManagedObject>(left: ToOneRelationship<Entity>, right: Entity?) -> Predicate {
    return Predicate(predicate: left.nsExpression == Entity.nsExpression(right))
}

public func !=<Entity: NSManagedObject>(left: ToOneRelationship<Entity>, right: Entity?) -> Predicate {
    return Predicate(predicate: left.nsExpression != Entity.nsExpression(right))
}