//
//  CoffeeViewPresenter.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/2/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import Foundation

protocol CoffeeView: class {
    func setCoffeeImage(imageTitle: String)
    func setCoffeeDetails(with configurator: CoffeeDetailsConfigurator)
}

class CoffeePresenter {
    
    // MARK: - Properties
    
    var coffee: Coffee!
    
    weak var coffeeView: CoffeeView!
    
    // MARK: - Init Methods
    
    init(view: CoffeeView, coffee: Coffee) {
        self.coffeeView = view
        self.coffee = coffee
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        setCoffeeImage()
        setCoffeeDetails()
    }
    
    func setCoffeeImage() {
        coffeeView.setCoffeeImage(imageTitle:  coffee.imageOfIngredients ?? "ic_latte")
    }
    
    func setCoffeeDetails() {
        let coffeeDetailsConfigurator = CoffeeDetailsConfigurator(coffee: coffee)
        coffeeView.setCoffeeDetails(with: coffeeDetailsConfigurator)
    }
}
