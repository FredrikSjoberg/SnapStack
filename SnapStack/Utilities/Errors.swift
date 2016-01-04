//
//  Errors.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 2015-09-19.
//  Copyright © 2015 Fredrik Sjoberg. All rights reserved.
//

import Foundation
import CoreData

public enum SnapStackError : ErrorType {
    case InvalidModel
    case NoPersistentStoreCoordinator
    case NoPersistentStore
    case MigrationToInMemoryStoreNotAllowed
}

extension SnapStackError : LogType {
    public var level: LogLevel {
        return LogLevel.Warning
    }
    
    public var description: String {
        switch self {
        case .InvalidModel: return " | Invalid Managed Object Model"
        case .NoPersistentStoreCoordinator: return " | No Persistent Store Coordinator"
        case .NoPersistentStore: return " | No Persistent Store"
        case .MigrationToInMemoryStoreNotAllowed: return " | Migration to InMemory Store not allowed"
        }
    }
    
    public var debugDescription: String {
        return description
    }
}

public enum FetchError : ErrorType {
    case NotUnique(entityName: String, count: Int, predicate: NSPredicate?, context: NSManagedObjectContext)
    case CountNotAvaliable(entityName: String, predicate: NSPredicate?, context: NSManagedObjectContext)
}

extension FetchError : LogType {
    public var level: LogLevel {
        return LogLevel.Info
    }
    
    public var description: String {
        switch self {
        case let .NotUnique(entityName, count, predicate, context): return " | Fetch.unique() did not find a unique [\(count)] entity \(entityName), predicate: \(predicate) in context: \(context)"
        case let .CountNotAvaliable(entityName, predicate, context): return " | Fetch.count() found nothing to count for entity \(entityName), predicate: \(predicate) in context: \(context)"
        }
    }
    
    public var debugDescription: String {
        return description
    }
}