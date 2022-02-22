//
//  HomeConfigurator.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/2/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import Foundation
import CoreData

protocol HomeConfiguratorProtocol {
    func configure(controller: HomeView)
}

class HomeConfigurator: HomeConfiguratorProtocol {
    
    // MARK: - Methods
    
    func configure(controller: HomeView) {
        let router = HomeRouter(controller: controller)
        let storeURL = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("coffee-store.sqlite")
        let coffeeArray = try! CoreDataStore(storeURL: storeURL).getCoffeeData() ?? []

        let presenter = HomePresenter(coffeeArray: coffeeArray, view: controller, router: router)
        controller.setPresenter(presenter: presenter)
    }
}
