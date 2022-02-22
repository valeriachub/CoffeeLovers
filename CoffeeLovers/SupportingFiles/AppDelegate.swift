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
        let mainController = MainUIComposer.mainComposedWith(storeURL: storeURL)
        let mainImageTitle = "ic_coffee"
        
        let favouriteController = MainUIComposer.mainComposedWith(storeURL: storeURL)
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
            navViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: tab.imageName), tag: index)
            tabControllers.append(navViewController)
        }
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = tabControllers
        return tabBarController
    }
}

private class OrangeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
    }
}

public final class MainUIComposer {
    
    public static func mainComposedWith(storeURL: URL) -> MainController {
        let localCoffee = try! CoreDataStore(storeURL: storeURL).getCoffeeData() ?? []
        let controller = MainController()
        let presenter = MainPresenter(localCoffee: localCoffee, view: WeakWrapper(controller))
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

extension WeakWrapper: MainView where T: MainView {
    
}
