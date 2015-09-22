//
//  ValueType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 22/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public protocol ValueType {
    var nsExpression: NSExpression { get }
    static func nsExpression(value: ValueType?) -> NSExpression
}

public extension ValueType {
    static func nsExpression(value: ValueType?) -> NSExpression {
        if let actual = value {
            return actual.nsExpression
        }
        else {
            return NSExpression(forConstantValue: NSNull())
        }
    }
}

extension String : ValueType {
    public var nsExpression: NSExpression {
        return NSExpression(forConstantValue: self as NSString)
    }
}

extension Int : ValueType {
    public var nsExpression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(integer: self))
    }
}

extension Int64 : ValueType {
    public var nsExpression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(longLong: self))
    }
}

extension Int32 : ValueType {
    public var nsExpression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(int: self))
    }
}

extension Int16 : ValueType {
    public var nsExpression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(short: self))
    }
}

extension Float : ValueType {
    public var nsExpression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(float: self))
    }
}

extension Double : ValueType {
    public var nsExpression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(double: self))
    }
}

extension Bool : ValueType {
    public var nsExpression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(bool: self))
    }
}

extension NSDate : ValueType {
    public var nsExpression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

extension NSDecimalNumber : ValueType {
    public var nsExpression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}