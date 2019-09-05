//
//  HomeConfigurator.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/2/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import Foundation

protocol HomeConfiguratorProtocol: class {
    func configure(controller: HomeView)
}

class HomeConfigurator: HomeConfiguratorProtocol {
    
    // MARK: - Methods
    
    func configure(controller: HomeView) {
        let router = HomeRouter(controller: controller)
        let presenter = HomePresenter(view: controller, router: router)
        controller.setPresenter(presenter: presenter)
    }
}
