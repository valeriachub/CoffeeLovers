//
//  CoffeeDetailsPresenter.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/2/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import Foundation

protocol CoffeeDetailsView: class {
    func setCoffeeTitle(title: String)
}

class CoffeeDetailsPresenter {
    
    // MARK: - Properties
    
    var coffee: Coffee!
    
    weak var coffeeDetailsView: CoffeeDetailsView!
    
    // MARK: - Init Methods
    
    init(view: CoffeeDetailsView, coffee: Coffee) {
        self.coffeeDetailsView = view
        self.coffee = coffee
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        coffeeDetailsView.setCoffeeTitle(title: coffee.title ?? "")
    }
    
}


