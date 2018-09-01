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
        let testRequest : NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        do{
            let count = try context.fetch(testRequest).count
            print("\(count)")
            return count == 0
        }catch{
            print("Empty")
        }
        return true
    }
    
    func preloadData(context : NSManagedObjectContext){
        guard let path = Bundle.main.path(forResource: "CoffeeData", ofType: "json") else { fatalError("No CoffeeData.json file") }
        
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let jsonObj = try JSON(data: data)
            
            preloadIngredients(context: context, jsonObj: jsonObj)
            preloadCoffee(context : context, jsonObj: jsonObj)
            
            do {
                try context.save()
            } catch {
                print("Save Error")
            }
            
        } catch let error {
            print("parse error: \(error.localizedDescription)")
        }
    }
    
    func preloadIngredients(context : NSManagedObjectContext, jsonObj : JSON){
        let ingredientArray = jsonObj["ingredient"]
        
        for (_, object) in ingredientArray {
            let newIngredient = Ingredient(context: context)
            newIngredient.setValue(object["title"].stringValue, forKey: "title")
            newIngredient.setValue(object["calories"].doubleValue , forKey: "calories")
        }
    }
    
    func preloadCoffee(context : NSManagedObjectContext, jsonObj : JSON){
        let coffeeArray = jsonObj["coffee"]
        
        for (_, coffee) in coffeeArray {
            let newCoffee = Coffee(context: context)
            newCoffee.setValue(coffee["title"].stringValue, forKey: "title")
            newCoffee.setValue(coffee["image"].stringValue, forKey: "image")
            newCoffee.setValue(coffee["isFavourite"].boolValue, forKey: "isFavourite")
            
            for(_, item) in coffee["ingredient"] {
                let newIngredient = IngredientOfCoffee(context: context)
                newIngredient.setValue(item["percentage"].doubleValue, forKey: "percentage")
                newIngredient.coffee = newCoffee
                guard let ingredient = fetchIngredient(context: context, title: item["title"].stringValue) else {fatalError("Error fetching Ingredient")}
                newIngredient.ingredient = ingredient
            }
        }
    }
    
    func fetchIngredient(context : NSManagedObjectContext, title : String ) -> Ingredient?{
        let request : NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        do{
            let ingredient = try context.fetch(request)[0]
            return ingredient
            
        }catch {
            print("Error fetching Ingredient")
        }
        return nil
    }
}

