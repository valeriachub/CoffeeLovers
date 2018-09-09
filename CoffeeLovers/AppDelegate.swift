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
    
    func preloadCoffee(context : NSManagedObjectContext, jsonObj : JSON){
        let coffeeArray = jsonObj["coffee"]
        
        for (_, coffee) in coffeeArray {
            let newCoffee = Coffee(context: context)
            newCoffee.setValue(coffee["title"].stringValue, forKey: "title")
            newCoffee.setValue(coffee["imageIngredients"].stringValue, forKey: "imageIngredients")
            newCoffee.setValue(coffee["isFavourite"].boolValue, forKey: "isFavourite")
            newCoffee.setValue(coffee["calories"].doubleValue, forKey: "calories")
            
            for (_, imageTitle) in coffee["imageSet"] {
                let newImage = ImageSet(context: context)
                newImage.setValue(imageTitle.stringValue, forKey: "title")
                newImage.coffee = newCoffee
            }
        }
    }
}

