//
//  CoffeeDataService.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/30/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import CoreData

public final class CoreDataStore {
    private static let modelName = "CoffeeLoversDB"
    private static let model: NSManagedObjectModel? = Bundle(for: ManagedCoffee.self)
        .url(forResource: modelName, withExtension: "momd")
        .flatMap { NSManagedObjectModel(contentsOf: $0) }
    
    enum StoreError: Swift.Error {
        case modelNotFound
        case failedLoadPersistentContainer(Error)
    }
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    init(storeURL: URL) throws {
        guard let model = CoreDataStore.model else {
            throw StoreError.modelNotFound
        }
        
        do {
            container = try NSPersistentContainer.load(name: CoreDataStore.modelName, model: model, from: storeURL)
            context = container.newBackgroundContext()
            
        } catch {
            throw StoreError.failedLoadPersistentContainer(error)
        }
    }
}

extension CoreDataStore {
    
    private var IS_DATA_PRELOADED: String { "isDataPreloaded" }
    private var COFFEE_DATA: String { "CoffeeData" }
    private var JSON: String { "json" }
    
    struct FailedLoadJson: Swift.Error {}
    struct FailedMapJson: Swift.Error {}
    
    func preloadData() {
        guard UserDefaults.standard.bool(forKey: IS_DATA_PRELOADED) == false else {
            return
        }
        
        loadDataFromJson { result in
            if let models = try? result.get() {
                saveCoffeeModels(models)
                UserDefaults.standard.set(true, forKey: IS_DATA_PRELOADED)
            } else {
                print(result.mapError { $0 })
            }
        }
    }
    
    private func loadDataFromJson(completion: (Result<[CoffeeModel], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: COFFEE_DATA, withExtension: JSON) else {
            completion(.failure(FailedLoadJson()))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let root = try JSONDecoder().decode(Root.self, from: data)
            completion(.success(root.coffee))
        } catch {
            completion(.failure(FailedMapJson()))
        }
    }
    
    func saveCoffeeModels(_ models: [CoffeeModel]) {
        for model in models {
            let managedCoffee = ManagedCoffee(context: context)
            managedCoffee.title = model.title
            managedCoffee.image = model.image
            managedCoffee.descriptions = model.descriptions
            managedCoffee.is_favourite = model.is_favourite
            managedCoffee.ingredients = NSOrderedSet()
            managedCoffee.recipe = NSOrderedSet()
            
            for ingredient in model.ingredients {
                managedCoffee.addToIngredients(StringHolder(value: ingredient, context: context))
            }
            
            for recipe in model.recipe {
                managedCoffee.addToRecipe(StringHolder(value: recipe, context: context))
            }
            
            try? context.save()
        }
    }
}

extension CoreDataStore {
    
    func updateCoffeeFavority(_ coffee: Coffee, updatedCoffee: @escaping (Coffee) -> Void) {
        guard let managedCoffee = ManagedCoffee.managedCoffee(of: coffee, from: context) else {
            updatedCoffee(coffee)
            return
        }
        
        let isFavourite = !coffee.isFavourite
        managedCoffee.is_favourite = isFavourite
        do {
            try context.save()
            let newCoffee = Coffee(title: coffee.title, image: coffee.image, isFavourite: isFavourite, descriptions: coffee.descriptions, ingredients: coffee.ingredients, recipeSteps: coffee.recipeSteps)
            updatedCoffee(newCoffee)
        } catch {
            updatedCoffee(coffee)
        }
    }
}

extension CoreDataStore {
    
    func getCoffeeData() -> [Coffee]? {
        return try? context.fetch(ManagedCoffee.sortedFetchRequest).map { $0.coffee }
    }
}

private extension NSPersistentContainer {
    
    static func load(name: String, model: NSManagedObjectModel, from url: URL) throws -> NSPersistentContainer {
        let description = NSPersistentStoreDescription(url: url)
        let container = NSPersistentContainer(name: name, managedObjectModel: model)
        container.persistentStoreDescriptions = [description]
        
        var error: Swift.Error?
        container.loadPersistentStores { error = $1 }
        try error.map { throw $0 }
        
        return container
    }
}

struct Root: Codable {
    let coffee: [CoffeeModel]
}

struct CoffeeModel: Codable {
    let title: String
    let image: String
    let is_favourite: Bool
    let descriptions: String
    let ingredients: [String]
    let recipe: [String]
    
}
public struct Coffee {
    let title: String
    let image: String
    let isFavourite: Bool
    let descriptions: String
    let ingredients: [String]
    let recipeSteps: [String]
}
