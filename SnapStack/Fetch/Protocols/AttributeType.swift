//
//  AttributeType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 22/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public protocol AttributeType : KeyedType {
    typealias Value: ValueType
}

public extension AttributeType {
    public func ascending() -> NSSortDescriptor {
        return NSSortDescriptor(key: key, ascending: true)
    }
    
    public func descending() -> NSSortDescriptor {
        return NSSortDescriptor(key: key, ascending: false)
    }
}