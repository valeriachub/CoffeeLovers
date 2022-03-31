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
        let service = try! CoreDataStore(storeURL: storeURL)
        service.preloadData()
    }
    
    private func setRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = getRootViewController()
        window?.makeKeyAndVisible()
    }
    
    private func getRootViewController() -> UITabBarController {
        
        let mainCollectionTabNavigationController = CollectionUIComposer.composedWith(storeURL: storeURL, isFavouriteTab: false, imageName: "ic_coffee", tag: 0)
        let favouriteCollectionTabNavigationController = CollectionUIComposer.composedWith(storeURL: storeURL, isFavouriteTab: true, imageName: "ic_favourite", tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainCollectionTabNavigationController, favouriteCollectionTabNavigationController]
        
        return tabBarController
    }
}

public final class CollectionUIComposer {
    
    public static func composedWith(storeURL: URL, isFavouriteTab: Bool, imageName: String, tag: Int) -> CollectionTabNavigationController {
        let localCoffee = try! CoreDataStore(storeURL: storeURL).getCoffeeData() ?? []
        let controller = CoffeeCollectionViewController()
        let navigationController = CollectionTabNavigationController(rootViewController: controller, imageName: imageName, tag: tag)
        let selection: (LocalCoffee) -> Void = { [weak navigationController] coffee in
            let controller = CollectionUIComposer.getCoffeeController(for: coffee)
            navigationController?.pushViewController(controller, animated: true)
        }
        
        let presenter = CoffeeCollectionPresenter(localCoffee: localCoffee, view: WeakWrapper(controller), isFavourite: isFavouriteTab, select: selection)
        controller.presenter = presenter
        return navigationController
    }
    
    private static func getCoffeeController(for coffee: LocalCoffee) -> CoffeeController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CoffeeController") as! CoffeeController
        let presenter = CoffeePresenter(view: controller, coffee: coffee)
        controller.presenter = presenter
        return controller
    }
}

public class WeakWrapper<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakWrapper: CoffeeCollectionView where T: CoffeeCollectionView {}

