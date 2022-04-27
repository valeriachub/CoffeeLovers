//
//  StringHolder.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 01.04.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import Foundation
import CoreData

@objc(StringHolder)
public class StringHolder: NSManagedObject {
    @NSManaged public var value: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<StringHolder> {
        return NSFetchRequest<StringHolder>(entityName: "StringHolder")
    }
}

extension StringHolder {
    
    convenience init(value: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.value = value
    }
}
