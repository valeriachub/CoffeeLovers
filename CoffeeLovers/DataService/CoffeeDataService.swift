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
    
    // MARK: - Singleton init
    
    static let shared = CoffeeDataService()
    private init() {}
    
    
    // MARK: - Methods
    
    func getCoffeeArray() -> [Coffee] {
        var coffeeArray = [Coffee]()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Coffee> = Coffee.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        do {
            coffeeArray = try context.fetch(request)
        } catch {
            print("Error Load Coffee Data")
        }
        
        return coffeeArray
    }
}
