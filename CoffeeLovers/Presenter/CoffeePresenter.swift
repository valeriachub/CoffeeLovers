//
//  CoffeeViewPresenter.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/2/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import Foundation

protocol CoffeeView: AnyObject {
    func setCoffeeDetails(with configurator: CoffeeDetailsConfigurator)
    func setImage(title: String)
    func goBack()
}

class CoffeePresenter {
    
    // MARK: - Properties
    
    private var coffee: LocalCoffee!
    
    var imageName: String {
        return coffee.image
    }
    
    weak var coffeeView: CoffeeView!
    
    // MARK: - Init Methods
    
    init(view: CoffeeView, coffee: LocalCoffee) {
        self.coffeeView = view
        self.coffee = coffee
    }
    
    // MARK: - Methods
    
    func setViews() {
        setCoffeeImage()
        setCoffeeDetails()
    }
    
    func setCoffeeImage() {
        coffeeView.setImage(title: coffee.image)
    }
    
    func setCoffeeDetails() {
        let coffeeDetailsConfigurator = CoffeeDetailsConfigurator(coffee: coffee)
        coffeeView.setCoffeeDetails(with: coffeeDetailsConfigurator)
    }
    
    
    func closeAction() {
        coffeeView.goBack()
    }
}
