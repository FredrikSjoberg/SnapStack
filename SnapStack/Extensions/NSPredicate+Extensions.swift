//
//  NSPredicate+Extensions.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 22/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

/// Creates an AND NSPredicate from left and right
public func && (left: NSPredicate, right: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(type: .AndPredicateType, subpredicates: [left, right])
}

/// Creates an OR NSPredicate from left and right
public func || (left: NSPredicate, right: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(type: .OrPredicateType, subpredicates: [left, right])
}

/// Reverses an NSPredicate
prefix public func ! (left: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate(type: .NotPredicateType, subpredicates: [left])
}