//
//  FetchType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 22/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation
import CoreData

public protocol FetchType {
    typealias Entity: NSManagedObject
    
    var predicate: NSPredicate? { get set }
    var sortDescriptors: [NSSortDescriptor]? { get set }
    var context: NSManagedObjectContext { get }
    var entityName: String { get }
}

public extension FetchType {
    func filter(predicate: NSPredicate) -> Self {
        var clone = self
        if let oldPredicate = clone.predicate {
            clone.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [oldPredicate, predicate])
        }
        return clone
    }
    
    func sort(descriptor: NSSortDescriptor) -> Self {
        var clone = self
        if clone.sortDescriptors != nil {
            clone.sortDescriptors!.append(descriptor)
        }
        else {
            clone.sortDescriptors = [descriptor]
        }
        return clone
    }
    
    func filter(closure: (Entity.Type) -> Predicate) -> Self {
        return filter(closure(Entity).predicate)
    }
    
    func sort(closure: (Entity.Type) -> SortDescriptor) -> Self {
        return sort(closure(Entity).sortDescriptor)
    }
}

public extension FetchType {
    var nsFetchRequest: NSFetchRequest {
        let request = NSFetchRequest(entityName: entityName)
        
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        /*
        if let range = range {
        request.fetchOffset = range.startIndex
        request.fetchLimit = range.endIndex - range.startIndex
        request.fetchBatchSize = (self.limit > 0 && self.batchSize > self.limit ? 0 : self.batchSize)
        }*/
        
        return request
    }
}

public extension FetchType {
    func execute() throws -> [Entity] {
        return try context.executeFetchRequest(nsFetchRequest) as! [Entity]
    }
    
    func count() throws -> Int {
        var error: NSError? = nil
        let num = context.countForFetchRequest(nsFetchRequest, error: &error)
        
        if let error = error {
            throw error
        }
        
        guard num != NSNotFound else { throw FetchError.CountNotAvaliable(entityName: entityName, predicate: predicate, context: context) }
        return num
    }
    
    func unique() throws -> Entity {
        let result = try execute()
        let num = result.count
        guard num == 1 else { throw FetchError.NotUnique(entityName: entityName, count: num, predicate: predicate, context: context) }
        return result.first!
    }
}