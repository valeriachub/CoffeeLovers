//
//  CaloriesSize+CoreDataProperties.swift
//  
//
//  Created by Valeria Chub on 9/11/19.
//
//

import Foundation
import CoreData


extension CaloriesSize {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CaloriesSize> {
        return NSFetchRequest<CaloriesSize>(entityName: "CaloriesSize")
    }

    @NSManaged public var s: Double
    @NSManaged public var m: Double
    @NSManaged public var l: Double
    @NSManaged public var coffee: Coffee?

}
