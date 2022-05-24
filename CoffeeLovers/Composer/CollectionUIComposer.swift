//
//  CollectionUIComposer.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 29.04.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

public final class CollectionUIComposer {
    
    public static func composedWith(coffeeData: [Coffee], localDataLoader: LocalDataLoader, isFavouriteTab: Bool, image: UIImage, tag: Int) -> CollectionTabNavigationController {

        let localNotificationService = LocalNotificationService(coffeeData: coffeeData)
        let controller = CoffeeCollectionViewController()
        let navigationController = CollectionTabNavigationController(rootViewController: controller, image: image, tag: tag)
        let selection: (Coffee) -> Void = { [weak navigationController] coffee in
            let controller = CollectionUIComposer.getCoffeeController(for: coffee, localNotificationService: localNotificationService, localDataLoader: localDataLoader)
            navigationController?.pushViewController(controller, animated: true)
        }
        
        let presenter = CoffeeCollectionPresenter(localCoffee: coffeeData, view: WeakWrapper(controller), isFavourite: isFavouriteTab, select: selection)
        controller.presenter = presenter
        return navigationController
    }
    
    private static func getCoffeeController(for coffee: Coffee, localNotificationService: LocalNotificationService, localDataLoader: LocalDataLoader) -> CoffeeController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CoffeeController") as! CoffeeController
        let presenter = CoffeePresenter(view: controller, coffee: coffee, localNotificationService: localNotificationService, localDataLoader: localDataLoader)
        controller.presenter = presenter
        return controller
    }
}
