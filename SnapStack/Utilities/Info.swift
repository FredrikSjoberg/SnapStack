//
//  Info.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 06/10/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation
import CoreData

public enum SnapStackInfo {
    case NoChangesToCommit(context: NSManagedObjectContext)
    case CommitedChanges(context: NSManagedObjectContext)
}

extension SnapStackInfo : LogType {
    public var level: LogLevel {
        return LogLevel.Info
    }
    
    public var description: String {
        switch self {
        case let .NoChangesToCommit(context): return " | No changes to commit for \(context.name))"
        case let .CommitedChanges(context): return " | Commited \(context.name)"
        }
    }
    
    public var debugDescription: String {
        return description
    }
}


public enum OperationInfo {
    case ResetingAfterCommit(context: NSManagedObjectContext)
    case EditAfterCommit(context: NSManagedObjectContext, entity: NSManagedObject?)
    case DeleteAfterCommit(context: NSManagedObjectContext, entity: NSManagedObject)
}

extension OperationInfo : LogType {
    public var level: LogLevel {
        return LogLevel.Info
    }
    
    public var description: String {
        switch self {
        case let .ResetingAfterCommit(context): return " | \(context.name) tried to reset after commit"
        case let .EditAfterCommit(context, entity): return " | \(context.name) tried to edit entity after commit:\n \(entity)"
        case let .DeleteAfterCommit(context, entity): return " | \(context.name) tried to delete entity after commit:\n \(entity)"
        }
    }
    
    public var debugDescription: String {
        return description
    }
}