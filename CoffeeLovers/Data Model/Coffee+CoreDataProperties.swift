//
//  Coffee+CoreDataProperties.swift
//  
//
//  Created by Valeria Chub on 9/11/19.
//
//

import Foundation
import CoreData


extension Coffee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coffee> {
        return NSFetchRequest<Coffee>(entityName: "Coffee")
    }

    @NSManaged public var descriptions: String?
    @NSManaged public var image: String?
    @NSManaged public var ingredients: [String]?
    @NSManaged public var is_favourite: Bool
    @NSManaged public var recipe: [String]?
    @NSManaged public var title: String?
    @NSManaged public var calories_solo: Double
    @NSManaged public var calories_size: CaloriesSize?

}

// MARK: Generated accessors for calories_size
extension Coffee {

    @objc(addCalories_sizeObject:)
    @NSManaged public func addToCalories_size(_ value: CaloriesSize)

    @objc(removeCalories_sizeObject:)
    @NSManaged public func removeFromCalories_size(_ value: CaloriesSize)

    @objc(addCalories_size:)
    @NSManaged public func addToCalories_size(_ values: NSSet)

    @objc(removeCalories_size:)
    @NSManaged public func removeFromCalories_size(_ values: NSSet)

}
