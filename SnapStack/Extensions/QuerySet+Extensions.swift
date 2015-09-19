//
//  QuerySet+Extensions.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 2015-09-17.
//  Copyright © 2015 Fredrik Sjoberg. All rights reserved.
//

import Foundation


public extension QuerySet {
    public func unique() throws -> ModelType? {
        let result = try array()
        guard result.count == 1 else { return nil }
        return result.first
    }
}