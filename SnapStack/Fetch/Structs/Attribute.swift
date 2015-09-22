//
//  Attribute.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 21/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public struct Attribute<T: ValueType> {
    public typealias Value = T
    
    public let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public init(keys: [String]) {
        self.init(key: keys.joinWithSeparator("."))
    }
}

extension Attribute : AttributeType { }


public func == <Value: ValueType>(left: Attribute<Value>, right: Value?) -> Predicate {
    return Predicate(predicate: left.nsExpression == Value.nsExpression(right))
}

public func != <Value: ValueType>(left: Attribute<Value>, right: Value?) -> Predicate {
    return Predicate(predicate: left.nsExpression != Value.nsExpression(right))
}

public func < <Value: ValueType>(left: Attribute<Value>, right: Value?) -> Predicate {
    return Predicate(predicate: left.nsExpression < Value.nsExpression(right))
}

public func <= <Value: ValueType>(left: Attribute<Value>, right: Value?) -> Predicate {
    return Predicate(predicate: left.nsExpression <= Value.nsExpression(right))
}

public func > <Value: ValueType>(left: Attribute<Value>, right: Value?) -> Predicate {
    return Predicate(predicate: left.nsExpression > Value.nsExpression(right))
}

public func >= <Value: ValueType>(left: Attribute<Value>, right: Value?) -> Predicate {
    return Predicate(predicate: left.nsExpression >= Value.nsExpression(right))
}