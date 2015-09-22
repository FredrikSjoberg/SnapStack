//
//  ToManyRelationType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 22/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public protocol ToManyRelationType : RelationType {
    
}

public extension ToManyRelationType {
    func count() -> Attribute<Int> {
        return Attribute(keys: [key, "@count"])
    }
    
    /*
    func min<Int>(inner: (Entity.Type) -> Attribute<Int>) -> Attribute<Int> {
    
    }*/
}

public extension ToManyRelationType {
    func isIn(values: [Entity]?) -> Predicate {
        let predicate = NSComparisonPredicate(leftExpression: self.nsExpression, rightExpression: Array.nsExpression(values), modifier: .DirectPredicateModifier, type: .InPredicateOperatorType, options: NSComparisonPredicateOptions(rawValue: 0))
        return Predicate(predicate: predicate)
    }
}
