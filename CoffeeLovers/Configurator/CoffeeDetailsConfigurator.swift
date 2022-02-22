//
//  CoffeeDetailsConfigurator.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/2/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import Foundation

protocol CoffeeDetailsConfiguratorProtocol {
    func configure(controller: CoffeeDetailsController)
}

class CoffeeDetailsConfigurator: CoffeeDetailsConfiguratorProtocol {
    
    // MARK: - Properties
    
    var coffee: LocalCoffee!
    
    // MARK: - Init Methods
    
    init(coffee: LocalCoffee) {
        self.coffee = coffee
    }
    
    // MARK: - Methods
    
    func configure(controller: CoffeeDetailsController) {
        let presenter = CoffeeDetailsPresenter(view: controller, coffee: coffee)
        controller.presenter = presenter
    }
}
