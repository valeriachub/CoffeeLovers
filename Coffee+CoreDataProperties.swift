//
//  Coffee+CoreDataProperties.swift
//  
//
//  Created by Valeria Chub on 9/12/19.
//
//

import Foundation
import CoreData


extension Coffee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coffee> {
        return NSFetchRequest<Coffee>(entityName: "Coffee")
    }

    @NSManaged public var calories_solo: Double
    @NSManaged public var descriptions: String?
    @NSManaged public var image: String?
    @NSManaged public var ingredients: NSObject?
    @NSManaged public var is_favourite: Bool
    @NSManaged public var recipe: NSObject?
    @NSManaged public var title: String?
    @NSManaged public var calories_size: CaloriesSize?

}
