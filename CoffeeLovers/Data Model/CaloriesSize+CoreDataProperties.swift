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

    @NSManaged public var s: Int16
    @NSManaged public var m: Int16
    @NSManaged public var l: Int16
    @NSManaged public var coffee: Coffee?

}
