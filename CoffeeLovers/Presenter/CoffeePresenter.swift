//
//  CoffeeViewPresenter.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/2/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import Foundation

struct CoffeeViewModel {
    let title: String
    let imageTitle: String
    let description: String
    let ingredients: [String]
    let recipe: [String]
}

protocol CoffeeView: AnyObject {
    func display(viewModel: CoffeeViewModel)
    
    func goBack()
}

class CoffeePresenter {
    
    // MARK: - Properties
    
    private var coffee: Coffee!
    
    var imageName: String {
        return coffee.image
    }
    
    
    weak var coffeeView: CoffeeView!
    
    // MARK: - Init Methods
    
    init(view: CoffeeView, coffee: Coffee) {
        self.coffeeView = view
        self.coffee = coffee
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        let viewModel = CoffeeViewModel(title: coffee.title, imageTitle: coffee.image, description: coffee.descriptions, ingredients: coffee.ingredients, recipe: coffee.recipeSteps)
        coffeeView.display(viewModel: viewModel)
    }
    
    func closeAction() {
        coffeeView.goBack()
    }
}
