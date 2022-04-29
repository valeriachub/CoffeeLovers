//
//  AppDelegate.swift
//  CoffeeLovers
//
//  Created by Valeria on 27.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private lazy var storeURL: URL = {
        return NSPersistentContainer
            .defaultDirectoryURL()
            .appendingPathComponent("coffee-store.sqlite")
    }()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        simulatePreloadDataForFirstLaunch()
        setRootViewController()
        
        return true
    }
}

extension AppDelegate {
    
    private func simulatePreloadDataForFirstLaunch() {
        CoreDataStore.simulatePreloadData(storeURL: storeURL)
    }
    
    private func setRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = getRootViewController()
        window?.makeKeyAndVisible()
    }
    
    private func getRootViewController() -> UITabBarController {
        
        let coreDataStore = try! CoreDataStore(storeURL: storeURL)
        let localCoffee = coreDataStore.getCoffeeData()
        
        let mainCollectionTabNavigationController = CollectionUIComposer.composedWith(coffeeData: localCoffee, coreDataStore: coreDataStore, isFavouriteTab: false, imageName: "ic_coffee", tag: 0)
        let favouriteCollectionTabNavigationController = CollectionUIComposer.composedWith(coffeeData: localCoffee, coreDataStore: coreDataStore, isFavouriteTab: true, imageName: "ic_favourite", tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .red
        tabBarController.viewControllers = [mainCollectionTabNavigationController, favouriteCollectionTabNavigationController]
        
        return tabBarController
    }
}
