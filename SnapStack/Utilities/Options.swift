//
//  Options.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 2015-09-19.
//  Copyright © 2015 Fredrik Sjoberg. All rights reserved.
//

import Foundation
import CoreData

public enum StoreType {
    case SQLite(url: NSURL)
    case InMemory
    
    var type: String {
        switch self {
        case .SQLite: return NSSQLiteStoreType
        case .InMemory: return NSInMemoryStoreType
        }
    }
    
    var url: NSURL? {
        switch self {
        case .SQLite(let value): return value
        default: return nil
        }
    }
}

public struct StoreOptions {
    public let managedObjectModelURL: NSURL
    
    public let storeType: StoreType
    public let configuration: String?
    public let options: [NSObject : AnyObject]?
    
    public init(modelURL: NSURL, storeURL: NSURL) {
        managedObjectModelURL = modelURL
        storeType = .SQLite(url: storeURL)
        configuration = nil
        options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
    }
    
    public init(modelURL: NSURL, storeType: StoreType, configuration: String? = nil, options: [NSObject : AnyObject]? = nil) {
        managedObjectModelURL = modelURL
        self.storeType = storeType
        self.configuration = configuration
        self.options = options
    }
    
    public init(oldOptions: StoreOptions, newStoreType: StoreType) {
        managedObjectModelURL = oldOptions.managedObjectModelURL
        storeType = newStoreType
        configuration = oldOptions.configuration
        options = oldOptions.options
    }
}