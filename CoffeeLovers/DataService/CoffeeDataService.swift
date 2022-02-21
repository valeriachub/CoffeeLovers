//
//  CoffeeDataService.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/30/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

// TODO remove UIKit
import UIKit
import CoreData

class CoffeeDataService {
    
    // MARK: - Methods
    
    func getCoffeeArray(isFavouritesOnly: Bool = false) -> [Coffee] {
        var coffeeArray = [Coffee]()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Coffee> = Coffee.fetchRequest()
        
        if isFavouritesOnly {
            request.predicate = NSPredicate(format: "is_favourite == 1")
        }
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        do {
            coffeeArray = try context.fetch(request)
        } catch {
            print("Error Load Coffee Data")
        }
        
        return coffeeArray
    }
    
    func setCoffeeFavourite(coffee: Coffee) {
        coffee.is_favourite = !coffee.is_favourite
        ((UIApplication.shared.delegate) as! AppDelegate).saveContext()
    }
}
