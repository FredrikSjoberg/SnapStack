//
//  ToManyRelation.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 22/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation
import CoreData

public struct ToManyRelationship<T: NSManagedObject> {
    public typealias Entity = T
    
    public let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public init(keys: [String]) {
        self.init(key: keys.joinWithSeparator("."))
    }
}

extension ToManyRelationship : ToManyRelationType { }

public extension Array where Element: NSManagedObject {
    public static func nsExpression(values: [Element]?) -> NSExpression {
        if let actual = values {
            return NSExpression(forConstantValue: actual)
        }
        else {
            return NSExpression(forConstantValue: NSNull())
        }
    }
}

public func <<<Entity: NSManagedObject>(left: ToManyRelationship<Entity>, right: [Entity]?) -> Predicate {
    return left.isIn(right)
}