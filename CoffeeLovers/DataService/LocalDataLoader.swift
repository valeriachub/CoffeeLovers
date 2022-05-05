//
//  LocalDataLoader.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 05.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import Foundation

public final class LocalDataLoader {
    private let store: CoffeeStore
    
    public init(store: CoffeeStore) {
        self.store = store
    }
}

extension LocalDataLoader {
    public typealias LoadResult = Swift.Result<[Coffee], Error>
    
    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
                
            case let .success(managedCoffee):
                completion(.success(managedCoffee.map { $0.coffee } ))
            }
        }
    }
}

extension LocalDataLoader {
    
    public func update(_ coffee: Coffee, completionSuccess: @escaping () -> Void) {
        store.update(coffee, completionSuccess: completionSuccess)
    }
}


extension LocalDataLoader {
    
    private var IS_DATA_PRELOADED: String { "isDataPreloaded" }
    private var COFFEE_DATA: String { "CoffeeData" }
    private var JSON: String { "json" }
    
    struct FailedLoadJson: Swift.Error {}
    struct FailedMapJson: Swift.Error {}
    
    public func preload() {
        guard UserDefaults.standard.bool(forKey: IS_DATA_PRELOADED) == false else {
            return
        }
        
        loadDataFromJson { result in
            guard let models = try? result.get() else {
                return
            }
            store.cache(models: models)
            UserDefaults.standard.set(true, forKey: IS_DATA_PRELOADED)
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
}

public struct Root: Codable {
    let coffee: [CoffeeModel]
}

public struct CoffeeModel: Codable {
    let title: String
    let image: String
    let is_favourite: Bool
    let descriptions: String
    let ingredients: [String]
    let recipe: [String]
}
