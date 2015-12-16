# SnapStack
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Language: Swift](https://img.shields.io/badge/lang-Swift-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://raw.githubusercontent.com/FredrikSjoberg/SnapStack/master/LICENSE)

## Simple Core Data Stack

## Example Usage

#### Fetch
Fetching can be specified and refined in steps. Every additional application of filters or sorting produces a new Fetch<T> struct.

Type-safe filtering and sorting is implemented by specifying Attribute<T> and ToOneRelationship<U> on your CoreData models.
In order to make chaining (ie deep search on relationships) work, implement extensions on ToOneRelationType and ToManyRelationType

```swift
class Car : NSManagedObject {
    @NSManaged var model: String
    @NSManaged var engine: Engine?
    @NSManaged var wheels: Set<Wheel>

    static var model: Attribute<String> { return Attribute(key: "model") }
    static var engine: ToOneRelationship<Engine> { return ToOneRelationship(key: "engine") }
    static var wheels: ToManyRelationship<Wheel> { return ToManyRelationship(key: "wheels") }
}

extension ToOneRelationType where Entity: Car {
    var model: Attribute<String> { return chain(Attribute(key: "model")) }
    var engine: ToOneRelationship<Engine> { return chain(ToOneRelationship(key: "engine")) }
    var wheels: ToManyRelationship<Wheel> { return chain(ToManyRelationship(key: "wheels")) }
}

class Engine : NSManagedObject {
    @NSManaged var cylinders: Int

    static var cylinders: Attribute<Int> { return Attribute(key: "cylinders") }
}

extension ToOneRelationType where Entity: Engine {
    var cylinders: Attribute<Int> { return chain(Attribute(key: "cylinders")) }
}

class Wheel : NSManagedObject {
    @NSManaged var diameter: Float

    static var diameter: Attribute<Float> { return Attribute(key: "diameter") }
}

extension ToOneRelationType where Entity: Wheel {
    var diameter: Attribute<Float> { return chain(Attribute(key: "diameter")) }
}

func fetchCars(snapStack: SnapStack) {
    let fetch = snapStack
        .fetch(Car)

    let filteredFetch = fetch
        .filter{ $0.model == "Volvo" }
        .filter{ $0.engine.cylinders == 6 }

    let sortedFetch = filteredFetch
        .sort{ $0.model.ascending() }

    do {
        let cars = try fetch.execute() // All cars
        let filteredCars = try filteredFetch.execute() // Only those with filter applied
        let sortedCars = try sortedFetch.execute() // Sorted
    }
    catch {
    // Handle errors...
    }
}

```

Inspiration:
- [Core Store](https://github.com/JohnEstropia/CoreStore)
- [AlecrimCoreData](https://github.com/Alecrim/AlecrimCoreData)
- [QueryKit](https://github.com/QueryKit/QueryKit)