//
//  RootUIComposer.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 05.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

public final class RootUIComposer {
    
    public static func getRoot(in window: UIWindow, localDataLoader: LocalDataLoader, completion: @escaping (UIViewController) -> Void) {
        
        localDataLoader.load { result in
            switch result {
            case let .success(coffee):
                completion(getRootController(with: coffee, in: window, loader: localDataLoader))
                
            case .failure:
                completion(getErrorViewController())
            }
        }
    }
    
    private static func getRootController(with coffee: [Coffee], in window: UIWindow, loader: LocalDataLoader) -> UIViewController {
        let isFirstLaunch = !(UserDefaults.standard.bool(forKey: "showedOnboarding"))
        let homeController = getTabBarViewController(for: coffee, localDataLoader: loader)
        guard isFirstLaunch else {
            return homeController
        }
        
        return OnboardingUIComposer.compose {
            UserDefaults.standard.set(true, forKey: "showedOnboarding")
            window.rootViewController = homeController
            window.makeKeyAndVisible()
        }
    }
    
    private static func getTabBarViewController(for localCoffee: [Coffee], localDataLoader: LocalDataLoader) -> UITabBarController {
        let mainCollectionTabNavigationController = CollectionUIComposer.composedWith(coffeeData: localCoffee, localDataLoader: localDataLoader, isFavouriteTab: false, image: UIImage(systemName: "cup.and.saucer")!, tag: 0)
        let favouriteCollectionTabNavigationController = CollectionUIComposer.composedWith(coffeeData: localCoffee, localDataLoader: localDataLoader, isFavouriteTab: true, image: UIImage(systemName: "heart")!, tag: 1)
        let newsController = NewsUIComposer.compose(with: UIImage(systemName: "newspaper")!, tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .red
        tabBarController.viewControllers = [mainCollectionTabNavigationController, favouriteCollectionTabNavigationController, newsController]
        
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
