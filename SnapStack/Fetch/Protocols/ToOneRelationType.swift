//
//  ToOneRelationType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 22/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public protocol ToOneRelationType : RelationType {
    
}

public extension ToOneRelationType {
    func chain<Entity>(next: Attribute<Entity>) -> Attribute<Entity> {
        return Attribute<Entity>(keys: [key, next.key])
    }
    
    func chain<Entity>(next: ToOneRelationship<Entity>) -> ToOneRelationship<Entity> {
        return ToOneRelationship<Entity>(keys: [key, next.key])
    }
    
    func chain<Entity>(next: ToManyRelationship<Entity>) -> ToManyRelationship<Entity> {
        return ToManyRelationship<Entity>(keys: [key, next.key])
    }
}