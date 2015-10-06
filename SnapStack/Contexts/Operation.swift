//
//  Operation.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 2015-09-15.
//  Copyright © 2015 Fredrik Sjoberg. All rights reserved.
//

import CoreData

public class Operation: NSManagedObjectContext {
    private let closure: (operation: Operation) -> Void
    private var commited = false
    
    // LoggingType
    public var logger: LogProcessorType?
    
    internal init(parent: SnapStackType, closure: (operation: Operation) -> Void) {
        self.closure = closure
        
        super.init(concurrencyType: .PrivateQueueConcurrencyType)
        
        self.parentContext = parent.mainContext
        
//        retainsRegisteredObjects = true // From old Operation
        name = "OperationContext"
    }
    
     required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func save() throws {
        guard hasChanges else { return }
        if !commited {
            commited = true
            try super.save()
        }
    }
    
    public override func reset() {
        if commited {
            logger?.deliver(OperationInfo.ResetingAfterCommit(context: self))
        }
        super.reset()
    }
    
    internal func perform() {
        performBlock { [unowned self] in
            self.closure(operation: self)
        }
    }
    
    internal func synchronized() {
        performBlockAndWait{ [unowned self] in
            self.closure(operation: self)
        }
    }
}

// MARK: - ContextType
extension Operation {
    public func create<T: NSManagedObject>(entity: T.Type) -> T? {
        return NSEntityDescription.insertNewObjectForEntityForName(entity.entityName(), inManagedObjectContext: handlerContext) as? T
    }
    
    public func edit<T: NSManagedObject>(entity: T?) -> T? {
        if commited {
            logger?.deliver(OperationInfo.EditAfterCommit(context: self, entity: entity))
        }
        return entity?.inContext(handlerContext)
    }
    
    public func delete<T: NSManagedObject>(entity: T) {
        if commited {
            logger?.deliver(OperationInfo.DeleteAfterCommit(context: self, entity: entity))
        }
        entity.inContext(handlerContext)?.deleteFromContext()
    }
}

// MARK: - CommitType
extension Operation : CommitType { }

// MARK: - LoggingType
extension Operation : LoggingType { }