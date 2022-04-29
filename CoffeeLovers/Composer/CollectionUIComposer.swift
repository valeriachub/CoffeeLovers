//
//  CollectionUIComposer.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 29.04.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

public final class CollectionUIComposer {
    
    public static func composedWith(coffeeData: [Coffee], coreDataStore: CoreDataStore, isFavouriteTab: Bool, imageName: String, tag: Int) -> CollectionTabNavigationController {

        let controller = CoffeeCollectionViewController()
        let navigationController = CollectionTabNavigationController(rootViewController: controller, imageName: imageName, tag: tag)
        let selection: (Coffee) -> Void = { [weak navigationController] coffee in
            let controller = CollectionUIComposer.getCoffeeController(for: coffee, coreDataStore: coreDataStore)
            navigationController?.pushViewController(controller, animated: true)
        }
        
        let presenter = CoffeeCollectionPresenter(localCoffee: coffeeData, view: WeakWrapper(controller), isFavourite: isFavouriteTab, select: selection)
        controller.presenter = presenter
        return navigationController
    }
    
    private static func getCoffeeController(for coffee: Coffee, coreDataStore: CoreDataStore) -> CoffeeController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CoffeeController") as! CoffeeController
        let presenter = CoffeePresenter(view: controller, coffee: coffee, coreDataStore: coreDataStore)
        controller.presenter = presenter
        return controller
    }
}
