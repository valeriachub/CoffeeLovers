//
//  RootUIComposer.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 05.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

public final class RootUIComposer {
    
    public static func getRoot(localDataLoader: LocalDataLoader, store: CoffeeStore, completion: @escaping (UIViewController) -> Void) {
        localDataLoader.load { result in
            switch result {
            case let .success(coffee):
                completion(getTabBarViewController(for: coffee, store: store as! CoreDataStore))

            case .failure:
                completion(getErrorViewController())
            }
        }
    }
    
    private static func getTabBarViewController(for localCoffee: [Coffee], store: CoreDataStore) -> UITabBarController {
        let mainCollectionTabNavigationController = CollectionUIComposer.composedWith(coffeeData: localCoffee, coreDataStore: store, isFavouriteTab: false, imageName: "ic_coffee", tag: 0)
        let favouriteCollectionTabNavigationController = CollectionUIComposer.composedWith(coffeeData: localCoffee, coreDataStore: store, isFavouriteTab: true, imageName: "ic_favourite", tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .red
        tabBarController.viewControllers = [mainCollectionTabNavigationController, favouriteCollectionTabNavigationController]
        
        return tabBarController
    }
    
    private static func getErrorViewController() -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .white
        let label = UILabel()
        label.text = "Oups... \nThe app was not able to load the data :'("
        label.font = UIFont(name: "Avenir Heavy", size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -24),
            label.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor),
        ])
        return controller
    }
}
