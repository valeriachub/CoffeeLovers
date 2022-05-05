//
//  CoreDataStore.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/30/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import CoreData

public protocol CoffeeStore {
    func cache(models: [CoffeeModel])
    func retrieve(completion: @escaping (Swift.Result<[ManagedCoffee], Error>) -> Void)
    func update(_ coffee: Coffee, completionSuccess: @escaping () -> Void)
}

public final class CoreDataStore: CoffeeStore {
    
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
    
    public init(storeURL: URL) throws {
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
    
    public func cache(models: [CoffeeModel]) {
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
    
    public func update(_ coffee: Coffee, completionSuccess: @escaping () -> Void) {
        guard let managedCoffee = ManagedCoffee.managedCoffee(of: coffee, from: context) else {
            return
        }
        
        let isFavourite = !coffee.isFavourite
        managedCoffee.is_favourite = isFavourite
        if let _ = try? context.save() {
            completionSuccess()
        }
    }
}

extension CoreDataStore {
    
    public func retrieve(completion: @escaping (Result<[ManagedCoffee], Error>) -> Void) {
        do {
            let managedCoffee = try context.fetch(ManagedCoffee.sortedFetchRequest)
            completion(.success(managedCoffee))
        } catch let error {
            completion(.failure(error))
        }
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
