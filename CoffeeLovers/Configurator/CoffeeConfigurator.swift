//
//  CoffeeConfigurator.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/2/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import Foundation

protocol CoffeeConfiguratorProtocol {
    func configure(controller: CoffeeController)
}

class CoffeeConfigurator: CoffeeConfiguratorProtocol {
    
    // MARK: - Properties
    
    var coffee: LocalCoffee
    
    // MARK: - Init Methods
    
    init(coffee: LocalCoffee) {
        self.coffee = coffee
    }
    
    // MARK: - Methods
    
    func configure(controller: CoffeeController) {
        let presenter = CoffeePresenter(view: controller, coffee: coffee)
        
        controller.presenter = presenter
    }
}
