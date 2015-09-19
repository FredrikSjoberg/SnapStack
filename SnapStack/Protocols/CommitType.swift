//
//  CommitType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 19/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation
import CoreData

public protocol CommitType : ContextType {
    func commit() throws
}

extension CommitType {
    public func commit() throws {
        guard handlerContext.hasChanges else { return }
        try handlerContext.save()
    }
}