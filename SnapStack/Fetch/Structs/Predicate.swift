//
//  Predicate.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 21/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public struct Predicate {
    public let predicate:NSPredicate
    
    public init(predicate:NSPredicate) {
        self.predicate = predicate
    }
}

public func && (left: Predicate, right: Predicate) -> Predicate {
    return Predicate(predicate: left.predicate && right.predicate)
}

public func || (left: Predicate, right: Predicate) -> Predicate {
    return Predicate(predicate: left.predicate || right.predicate)
}

public prefix func ! (predicate: Predicate) -> Predicate {
    return Predicate(predicate: !predicate.predicate)
}