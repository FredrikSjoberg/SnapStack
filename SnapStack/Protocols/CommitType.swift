//
//  CommitType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 19/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation
import CoreData

public protocol CommitType : ContextType, LoggingType {
    func commit() throws
}

extension CommitType {
    /// Commits any changes and throws errors
    public func commit() throws {
        guard handlerContext.hasChanges else {
            logger?.deliver(SnapStackInfo.NoChangesToCommit(context: handlerContext))
            return
        }
        try handlerContext.save()
        logger?.deliver(SnapStackInfo.CommitedChanges(context: handlerContext))
    }
    
    /// Tries to commit the changes and logs any errors
    public func commitAndLog() {
        do {
            try commit()
        }
        catch let commitError as NSError {
            logger?.deliver(commitError)
        }
    }
}