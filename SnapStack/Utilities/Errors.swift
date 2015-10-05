//
//  Errors.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 2015-09-19.
//  Copyright © 2015 Fredrik Sjoberg. All rights reserved.
//

import Foundation

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
  public   
    var debugDescription: String {
        return description
    }
}