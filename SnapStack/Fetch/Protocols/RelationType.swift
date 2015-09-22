//
//  RelationType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 22/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation
import CoreData

public protocol RelationType : KeyedType {
    typealias Entity: NSManagedObject
}