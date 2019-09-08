//
//  CaloriesSize+CoreDataProperties.swift
//  
//
//  Created by Valeria on 9/8/19.
//
//

import Foundation
import CoreData


extension CaloriesSize {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CaloriesSize> {
        return NSFetchRequest<CaloriesSize>(entityName: "CaloriesSize")
    }

    @NSManaged public var title: String?
    @NSManaged public var value: Int16
    @NSManaged public var coffee: Coffee?

}
