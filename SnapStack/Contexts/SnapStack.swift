//
//  SnapStack.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 2015-09-18.
//  Copyright © 2015 Fredrik Sjoberg. All rights reserved.
//

import Foundation
import CoreData

public class SnapStack : NSManagedObjectContext {
    private var storeOptions: StoreOptions
    private var rootSavingsContext: NSManagedObjectContext
    private var inMemoryStore: NSPersistentStore?
    
    public required init(storeOptions: StoreOptions) throws {
        self.storeOptions = storeOptions
        
        // root context
        rootSavingsContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        rootSavingsContext.name = "RootContext"
        
        super.init(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        name = "SnapStackContext"
        
        try configureStore()
    }
    
    private func configureStore() throws {
        // managed object model
        guard
            let managedObjectModel = NSManagedObjectModel(contentsOfURL: storeOptions.managedObjectModelURL)
            else {
                throw SnapStackError.InvalidModel
        }
        
        // persistent store coordinator
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        // persistent store
        let store = try coordinator.addPersistentStoreWithType(storeOptions.storeType.type, configuration: storeOptions.configuration, URL: storeOptions.storeType.url, options: storeOptions.options)
        rootSavingsContext.persistentStoreCoordinator = coordinator
        
        // Keep track of in-memory store
        switch storeOptions.storeType {
        case .InMemory: inMemoryStore = store
        default: break
        }
    }
    
    private func currentStore() throws -> NSPersistentStore {
        guard let coordinator = persistentStoreCoordinator else {
            throw SnapStackError.NoPersistentStoreCoordinator
        }
        
        switch storeOptions.storeType {
        case .SQLite(let url):
            guard let store = coordinator.persistentStoreForURL(url) else { throw SnapStackError.NoPersistentStore }
            return store
        case .InMemory:
            guard let store = inMemoryStore else { throw SnapStackError.NoPersistentStore }
            return store
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SnapStack : ContextType {
    public var handlerContext: NSManagedObjectContext {
        return self
    }
}

extension SnapStack : SnapStackType {
    public var options: StoreOptions {
        return storeOptions
    }
    
    public var mainContext: NSManagedObjectContext {
        return self
    }
    
    public var rootContext: NSManagedObjectContext {
        return rootSavingsContext
    }
    
    public func migrateTo(storeType: StoreType) throws -> NSPersistentStore {
        let newOptions = StoreOptions(oldOptions: storeOptions, newStoreType: storeType)
        
        guard let coordinator = persistentStoreCoordinator else {
            throw SnapStackError.NoPersistentStoreCoordinator
        }
        
        let oldStore = try currentStore()
        
        var newStore: NSPersistentStore? = nil
        switch storeType {
        case .SQLite(let value):
            newStore = try coordinator.migratePersistentStore(oldStore, toURL: value, options: newOptions.options, withType: storeType.type)
        default:
            throw SnapStackError.MigrationToInMemoryStoreNotAllowed
        }
        
        // Reference no longer needed
        switch storeOptions.storeType {
        case .InMemory: inMemoryStore = nil
        default: break
        }
        
        storeOptions = newOptions
        
        return newStore!
    }
}

