//
//  NSExpression+Extensions.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 22/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public func == (left: NSExpression, right: NSExpression) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: left, rightExpression: right, modifier: .DirectPredicateModifier, type: .EqualToPredicateOperatorType, options: NSComparisonPredicateOptions(rawValue: 0))
}

public func != (left: NSExpression, right: NSExpression) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: left, rightExpression: right, modifier: .DirectPredicateModifier, type: .NotEqualToPredicateOperatorType, options: NSComparisonPredicateOptions(rawValue: 0))
}

public func < (left: NSExpression, right: NSExpression) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: left, rightExpression: right, modifier: .DirectPredicateModifier, type: .LessThanPredicateOperatorType, options: NSComparisonPredicateOptions(rawValue: 0))
}

public func <= (left: NSExpression, right: NSExpression) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: left, rightExpression: right, modifier: .DirectPredicateModifier, type: .LessThanOrEqualToPredicateOperatorType, options: NSComparisonPredicateOptions(rawValue: 0))
}

public func > (left: NSExpression, right: NSExpression) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: left, rightExpression: right, modifier: .DirectPredicateModifier, type: .GreaterThanPredicateOperatorType, options: NSComparisonPredicateOptions(rawValue: 0))
}

public func >= (left: NSExpression, right: NSExpression) -> NSPredicate {
    return NSComparisonPredicate(leftExpression: left, rightExpression: right, modifier: .DirectPredicateModifier, type: .GreaterThanOrEqualToPredicateOperatorType, options: NSComparisonPredicateOptions(rawValue: 0))
}