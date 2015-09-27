//
//  Fetch.swift
//  SnapStack
//
//  Created by Fredrik Sjöberg on 21/09/15.
//  Copyright © 2015 Fredrik Sjöberg. All rights reserved.
//

import Foundation
import CoreData

public struct Fetch<T: NSManagedObject> {
    public typealias Entity = T
    
    public var predicate: NSPredicate?
    public var sortDescriptors: [NSSortDescriptor]?
    public let context: NSManagedObjectContext
    public let entityName: String
    
    public init(context: NSManagedObjectContext) {
        self.context = context
        self.entityName = T.entityName()
        predicate = nil
        sortDescriptors = nil
    }
}

extension Fetch : FetchType { }


/*
extension ToOneRelationType where Entity: ATest {
    var first: Attribute<Int> { return chain(Attribute<Int>(key: "named")) }
    var relation: ToOneRelationship<ASecond> { return chain(ToOneRelationship<ASecond>(key: "relation")) }
    var multi: ToManyRelationship<ASecond> { return chain(ToManyRelationship<ASecond>(key: "multi")) }
}

extension ToOneRelationType where Entity: ASecond {
    var named: Attribute<String> { return chain(Attribute<String>(key: "named")) }
    var backwards: ToOneRelationship<ATest> { return chain(ToOneRelationship<ATest>(key: "backwards")) }
}

func atest() -> ATest {}
func asecond() -> ASecond {}
func many() -> [ASecond] {}
func tryFetch() -> Fetch<ATest> { }
func test() {
    let a1 = atest()
    let a2 = asecond()
    let m = many()
    let fetch = tryFetch()
    let result2 = fetch.filter{ $0.multi << m }
    let r = try! result2.execute()
    let result1 = try! fetch.filter{ !($0.multi.count() == 10 && $0.relation == nil) }.execute()
    let result = try! fetch.filter{ $0.relation.backwards == a1 }.execute().map{ $0.first }.reduce(0){ $0 + $1 }
}

class ATest: NSManagedObject {
    @NSManaged var first: Int
    @NSManaged var relation: ASecond
    @NSManaged var multi: Set<ASecond>
    
//    static var first2 = Attribute<Int>(key: "first")
    class var first: Attribute<Int> { return Attribute<Int>(key: "first") }
    class var relation: ToOneRelationship<ASecond> { return ToOneRelationship<ASecond>(key: "relation") }
    class var multi: ToManyRelationship<ASecond> { return ToManyRelationship<ASecond>(key: "multi") }
}
class ASecond: NSManagedObject {
    @NSManaged var named: String
    @NSManaged var backwards: ATest
    
    class var first: Attribute<String> { return Attribute<String>(key: "named") }
    class var backwards: ToOneRelationship<ATest> { return ToOneRelationship<ATest>(key: "backwards") }
}*/