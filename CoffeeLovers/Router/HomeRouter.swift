//
//  HomeRouter.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/2/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

protocol HomeRouterProtocol: ViewRouter {
    func present(coffee: Coffee)
}

class HomeRouter: HomeRouterProtocol {
    
    // MARK: - Properties
    
    weak var homeController: HomeView?
    var coffee: Coffee?
    
    // MARK: - Init Methods
    
    init(controller: HomeView) {
        self.homeController = controller
    }
    
    // MARK: - Methods
    
    func present(coffee: Coffee) {
        self.coffee = coffee
        homeController?.performSegue(withIdentifier: SegueHelper.CoffeeSegue.rawValue)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let controller = segue.destination as? CoffeeController,
            let coffee = coffee {
            controller.configurator = CoffeeConfigurator(coffee: coffee)
        }
    }
}

