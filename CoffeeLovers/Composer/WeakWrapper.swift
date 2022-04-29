//
//  WeakWrapper.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 29.04.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import Foundation

public class WeakWrapper<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakWrapper: CoffeeCollectionView where T: CoffeeCollectionView {}

