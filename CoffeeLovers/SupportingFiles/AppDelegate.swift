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
        let mainController = CollectionUIComposer.composedWith(storeURL: storeURL, isFavouriteTab: false)
        let mainImageTitle = "ic_coffee"
        
        let favouriteController = CollectionUIComposer.composedWith(storeURL: storeURL, isFavouriteTab: true)
        let favouriteImageTitle = "ic_favourite"
        
        return getTabBarController(for: [
            (mainController, mainImageTitle),
            (favouriteController, favouriteImageTitle),
        ])
    }
    
    private func getTabBarController(for tabs: [(controller: UIViewController, imageName: String)]) -> UITabBarController {
        
        var tabControllers = [UINavigationController]()
        
        for (index, tab) in tabs.enumerated() {
            let navViewController = UINavigationController(rootViewController: tab.controller)
            navViewController.isNavigationBarHidden = true
            navViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: tab.imageName), tag: index)
            tabControllers.append(navViewController)
        }
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = tabControllers
        return tabBarController
    }
}

public final class CollectionUIComposer {
    
    public static func composedWith(storeURL: URL, isFavouriteTab: Bool) -> CoffeeCollectionViewController {
        let localCoffee = try! CoreDataStore(storeURL: storeURL).getCoffeeData() ?? []
        let controller = CoffeeCollectionViewController()
        let presenter = CoffeeCollectionPresenter(localCoffee: localCoffee, view: WeakWrapper(controller), isFavourite: isFavouriteTab)
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

extension WeakWrapper: CoffeeCollectionView where T: CoffeeCollectionView {
    
}
