//
//  CaloriesSize+CoreDataClass.swift
//  
//
//  Created by Valeria Chub on 9/12/19.
//
//

import Foundation
import CoreData

@objc(CaloriesSize)
public class CaloriesSize: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CaloriesSize> {
        return NSFetchRequest<CaloriesSize>(entityName: "CaloriesSize")
    }

    @NSManaged public var l: Double
    @NSManaged public var m: Double
    @NSManaged public var s: Double
    @NSManaged public var coffee: Coffee?

}
