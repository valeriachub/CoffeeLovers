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
    let isFavourite: Bool
}

protocol CoffeeView: AnyObject {
    func display(viewModel: CoffeeViewModel)
    
    func goBack()
}

class CoffeePresenter {
    
    // MARK: - Properties
    
    private var coffee: Coffee
    private var localDataLoader: LocalDataLoader
    private let localNotificationService: LocalNotificationService
    
    var imageName: String {
        return coffee.image
    }
    
    
    weak var coffeeView: CoffeeView!
    
    // MARK: - Init Methods
    
    init(view: CoffeeView, coffee: Coffee, localNotificationService: LocalNotificationService, localDataLoader: LocalDataLoader) {
        self.coffeeView = view
        self.coffee = coffee
        self.localDataLoader = localDataLoader
        self.localNotificationService = localNotificationService
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        displayCoffeeInfo()
    }
    
    private func displayCoffeeInfo() {
        let viewModel = CoffeeViewModel(title: coffee.title, imageTitle: coffee.image, description: coffee.descriptions, ingredients: coffee.ingredients, recipe: coffee.recipeSteps, isFavourite: coffee.isFavourite)
        coffeeView.display(viewModel: viewModel)
    }
    
    func closeAction() {
        coffeeView.goBack()
    }
    
    func likeButtonAction() {
        localDataLoader.update(coffee) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.coffee.isFavourite = !self.coffee.isFavourite
            self.displayCoffeeInfo()
            self.localNotificationService.updateMorningNotification()
        }
    }
}
