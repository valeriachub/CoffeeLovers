//
//  AppDelegate.swift
//  CoffeeLovers
//
//  Created by Valeria on 27.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import CoreData
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private lazy var store: CoffeeStore = {
        return try! CoreDataStore(
            storeURL: NSPersistentContainer
                .defaultDirectoryURL()
                .appendingPathComponent("coffee-store.sqlite"))
    }()
    
    private lazy var localDataLoader: LocalDataLoader = {
        return LocalDataLoader(store: store)
    }()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        simulatePreloadDataForFirstLaunch()
        setRootViewController()
        
        return true
    }
}

extension AppDelegate {
    
    private func simulatePreloadDataForFirstLaunch() {
        localDataLoader.preload()
    }
    
    private func setRootViewController() {
        RootUIComposer.getRoot(localDataLoader: localDataLoader) { [weak self] controller in
            self?.window = UIWindow(frame: UIScreen.main.bounds)
            self?.window?.rootViewController = controller
            self?.window?.makeKeyAndVisible()
        }
    }
}
