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
