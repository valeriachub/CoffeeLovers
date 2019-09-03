//
//  HomeConfigurator.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/2/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import Foundation

protocol HomeConfiguratorProtocol: class {
    func configure(controller: HomeController)
}

class HomeConfigurator: HomeConfiguratorProtocol {
    
    // MARK: - Methods
    
    func configure(controller: HomeController) {
        let router = HomeRouter(controller: controller)
        let presenter = HomePresenter(view: controller, router: router)
        controller.presenter = presenter
    }
}
