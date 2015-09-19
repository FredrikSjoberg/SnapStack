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