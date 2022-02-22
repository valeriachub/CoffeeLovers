//
//  Coffee+CoreDataClass.swift
//  
//
//  Created by Valeria Chub on 9/12/19.
//
//

import Foundation
import CoreData

@objc(Coffee)
public class Coffee: NSManagedObject {
    @NSManaged public var calories_solo: Double
    @NSManaged public var descriptions: String
    @NSManaged public var image: String
    @NSManaged public var is_favourite: Bool
    @NSManaged public var title: String
    @NSManaged public var calories_size: CaloriesSize?
    
    
    var localCoffee: LocalCoffee {
        return LocalCoffee(title: title, image: image, isFavourite: is_favourite, descriptions: descriptions)
    }
}
