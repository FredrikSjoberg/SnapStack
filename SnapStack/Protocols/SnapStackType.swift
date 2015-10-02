//
//  SnapStackType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 2015-09-19.
//  Copyright © 2015 Fredrik Sjoberg. All rights reserved.
//

import Foundation
import CoreData

public protocol SnapStackType : CommitType {
    var options: StoreOptions { get }
    var mainContext: NSManagedObjectContext { get }
    var rootContext: NSManagedObjectContext { get }
    var persistentStoreCoordinator: NSPersistentStoreCoordinator? { get }
    
    
    init(storeOptions: StoreOptions) throws
    
    func persist(async async: Bool) throws
    func migrateTo(storeType: StoreType) throws -> NSPersistentStore
    
    func operation(closure: (operation: Operation) -> Void)
}

extension SnapStackType {
    public func persist(async async: Bool) throws {
        try commit()
        
        var error: ErrorType? = nil
        func blockSave() {
            do { try self.rootContext.save() }
            catch let innerError { error = innerError }
        }
        
        if async { mainContext.performBlock { blockSave() } }
        else { mainContext.performBlockAndWait { blockSave() } }
        
        if let error = error { throw error }
    }
    
    public func operation(closure: (operation: Operation) -> Void) {
        Operation(parent: self, closure: closure).perform()
    }
    
    public func synchronized(closure: (operation: Operation) -> Void) {
        Operation(parent: self, closure: closure).synchronized()
    }
}