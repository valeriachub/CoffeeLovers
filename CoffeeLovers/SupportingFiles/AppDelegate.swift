//
//  AppDelegate.swift
//  CoffeeLovers
//
//  Created by Valeria on 27.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)
        
        let delegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        if !isDataBaseEmpty(context: context) { return true }
        else { preloadData(context: context)}
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoffeeLoversDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Preloading Data Methods
    
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
}

