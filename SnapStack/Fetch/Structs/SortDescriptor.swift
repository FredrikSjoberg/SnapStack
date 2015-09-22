//
//  SortDescriptor.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 21/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public struct SortDescriptor {
    public let sortDescriptor:NSSortDescriptor
    
    public init(sortDescriptor:NSSortDescriptor) {
        self.sortDescriptor = sortDescriptor
    }
}