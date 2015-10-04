//
//  ProgressReportingType.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 04/10/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation

public protocol ProgressReportingType {
    var progress: NSProgress { get set } // TODO: Make this optional?
    
//    func reportProgress(supervisor: NSProgress) -> Self
//    func reportProgress(supervisor: NSProgress, pending: Int64) -> Self
}

public extension ProgressReportingType {
    func reportProgress(supervisor: NSProgress) -> Self {
        return reportProgress(supervisor, pending: -1)
    }
    
    func reportProgress(supervisor: NSProgress, pending: Int64) -> Self {
        let clone = self
        supervisor.addChild(clone.progress, withPendingUnitCount: pending)
        return clone
    }
}