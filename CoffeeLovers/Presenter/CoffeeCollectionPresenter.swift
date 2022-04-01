//
//  MainController.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 22.02.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

protocol CoffeeCollectionView {
    
    
}

public class CoffeeCollectionPresenter {
    
    private let localCoffee: [Coffee]
    private var filtered: [Coffee] {
        get {
            return isFavourite ? localCoffee.filter { $0.isFavourite } : localCoffee
        }
    }
    private let view: CoffeeCollectionView
    private let isFavourite: Bool
    private let select: (Coffee) -> Void
    
    init(localCoffee: [Coffee], view: CoffeeCollectionView, isFavourite: Bool, select: @escaping (Coffee) -> Void) {
        self.localCoffee = localCoffee
        self.view = view
        self.isFavourite = isFavourite
        self.select = select
    }
    
    func image(for indexPath: IndexPath) -> String {
        return filtered[indexPath.item].image
    }
    
    func title(for indexPath: IndexPath) -> String {
        return filtered[indexPath.item].title
    }
    
    var count: Int {
        return filtered.count
    }
    
    func selectItemAt(_ indexPath: IndexPath) {
        select(filtered[indexPath.row])
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for index: IndexPath) -> T {
        let identifier = String.init(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: index) as! T
    }
}
