//
//  CoffeeDataService.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/30/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import CoreData
import SwiftyJSON

class CoffeeDataService {
    
    // MARK: - Methods
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoffeeLoversDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func getCoffeeArray(isFavouritesOnly: Bool = false) -> [Coffee] {
        var coffeeArray = [Coffee]()
        
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
        saveContext()
    }
    
    func preloadIfNeeded() {
        guard isDataBaseEmpty(context: context) else {
            return
        }
        preloadData(context: context)
    }
    
    func preloadData(context : NSManagedObjectContext){
        guard let path = Bundle.main.path(forResource: "CoffeeData", ofType: "json") else { fatalError("No CoffeeData.json file") }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let jsonObj = try JSON(data: data)
            
            preloadCoffee(context : context, jsonObj: jsonObj)
            
            saveContext()
            
        } catch let error {
            print("parse error: \(error.localizedDescription)")
        }
    }
    
    func preloadCoffee(context : NSManagedObjectContext, jsonObj : JSON) {
        let coffeeArray = jsonObj["coffee"]
        
        for (_, coffee) in coffeeArray {
            let newCoffee = Coffee(context: context)
            newCoffee.title = coffee["title"].stringValue
            newCoffee.image = coffee["image"].stringValue
            newCoffee.descriptions = coffee["descriptions"].stringValue
            newCoffee.is_favourite = false
            newCoffee.ingredients = [String]()
            newCoffee.recipe = [String]()
            newCoffee.calories_solo = coffee["calories_solo"].doubleValue
            
            for (_, ingredient) in coffee["ingredients"] {
                newCoffee.ingredients?.append(ingredient.stringValue)
            }
            
            for (_, item) in coffee["recipe"] {
                newCoffee.recipe?.append(item.stringValue)
            }
            
            let caloriesSize = CaloriesSize(context: context)
            if let caloriesSizeDict = coffee["calories_size"].dictionary {
                caloriesSize.s = caloriesSizeDict["s"]?.doubleValue ?? 0
                caloriesSize.m = caloriesSizeDict["m"]?.doubleValue ?? 0
                caloriesSize.l = caloriesSizeDict["l"]?.doubleValue ?? 0
            }
           newCoffee.calories_size = caloriesSize
            
            
            print(newCoffee)
        }
    }
    
    func isDataBaseEmpty(context : NSManagedObjectContext) -> Bool {
        let testRequest : NSFetchRequest<Coffee> = Coffee.fetchRequest()
        do {
            let count = try context.fetch(testRequest).count
            return count == 0
        }catch{
            print("Error fetching database")
        }
        return true
    }
    
    
    func saveContext () {

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
