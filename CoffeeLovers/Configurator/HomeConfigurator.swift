//
//  HomeConfigurator.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/2/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import Foundation

protocol HomeConfiguratorProtocol: class {
    func configure(controller: HomeViewController)
}

class HomeConfigurator: HomeConfiguratorProtocol {
    
    // MARK: - Methods
    
    func configure(controller: HomeViewController) {
        let router = HomeRouter(controller: controller)
        let presenter = HomeViewPresenter(view: controller, router: router)
        controller.presenter = presenter
    }
}
