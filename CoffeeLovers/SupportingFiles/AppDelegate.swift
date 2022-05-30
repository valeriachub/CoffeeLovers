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
import FirebaseMessaging

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
        setupMessaging(for: application)
        cleanBadgeCount(for: application)
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

extension AppDelegate: MessagingDelegate, UNUserNotificationCenterDelegate {
    
    private func setupMessaging(for application: UIApplication) {
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
        
        application.registerForRemoteNotifications()
    }
    
    private func cleanBadgeCount(for application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("fcmToken: \(String(describing: fcmToken))")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
        print(#function)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}
