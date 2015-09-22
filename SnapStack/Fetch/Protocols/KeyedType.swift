//
//  KeyedType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 21/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public protocol KeyedType {
    var key: String { get }
    var nsExpression: NSExpression { get }
}

public extension KeyedType {
    var nsExpression: NSExpression {
        return NSExpression(forKeyPath: key)
    }
}