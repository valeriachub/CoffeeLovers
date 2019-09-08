//
//  CaloriesSolo+CoreDataProperties.swift
//  
//
//  Created by Valeria on 9/8/19.
//
//

import Foundation
import CoreData


extension CaloriesSolo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CaloriesSolo> {
        return NSFetchRequest<CaloriesSolo>(entityName: "CaloriesSolo")
    }

    @NSManaged public var title: String?
    @NSManaged public var value: Int16
    @NSManaged public var coffee: Coffee?

}
