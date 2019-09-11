//
//  CoffeeDetailsPresenter.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/2/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

protocol CoffeeDetailsView: class {
    func setCoffeeTitle(title: String)
    func setCoffeeDescription(description: String)
    func setCoffeeIngredients(ingredients: [String])
    func setCornerRadius(_ radius: CGFloat)
    func setTableView(rowHeight: CGFloat, tableHeight: CGFloat)
    func setTabs(with titles: [String])
    func setGestures()
    func setReceiptText(text: String)
    func setReceiptTextHeight(height: CGFloat)
    func setMLTabs(with titles: [String])
    func updateLikeButton(isLike: Bool, isAnimate: Bool)
}

class CoffeeDetailsPresenter {
    
    // MARK: - Properties
    
    let coffeeService = CoffeeDataService.shared
    let cornerRadius: CGFloat = 30.0
    let rowHeight: CGFloat = 30.0
    let fullViewOriginY: CGFloat = 130.0
    
    var coffee: Coffee!
    var ingredients: [String]
    var recipe: [String]
    var partialViewOriginY: CGFloat {
        return UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 3) - 100
    }
    
    weak var coffeeDetailsView: CoffeeDetailsView!
    
    // MARK: - Init Methods
    
    init(view: CoffeeDetailsView, coffee: Coffee) {
        self.coffeeDetailsView = view
        self.coffee = coffee
        self.ingredients = coffee.ingredients ?? [String]()
        self.recipe = coffee.recipe ?? [String]()
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        setCoffee()
        setCornerRadius()
        setTableView()
        setTabs()
        setGestures()
        setReceiptText()
        setMLTabs()
    }
    
    func getNumberOfRowsIngredients() -> Int {
        return ingredients.count
    }
    
    func getCellForIngredientRow(at indexPath: IndexPath, of tableView: UITableView) -> IngredientCell {
        return IngredientCell.getCellForRowAt(indexPath: indexPath, of: tableView, for: ingredients[indexPath.row])
    }
    
    func setCoffee() {
        coffeeDetailsView.setCoffeeTitle(title: coffee.title ?? "")
        coffeeDetailsView.setCoffeeDescription(description: coffee.descriptions ?? "")
        
        coffeeDetailsView.updateLikeButton(isLike: coffee.is_favourite, isAnimate: false)
    }
    
    func setCornerRadius() {
        coffeeDetailsView.setCornerRadius(cornerRadius)
    }
    
    func setTableView() {
        coffeeDetailsView.setTableView(rowHeight: rowHeight, tableHeight: rowHeight * CGFloat(ingredients.count))
    }
    
    func setTabs() {
        coffeeDetailsView.setTabs(with: ["Receipt", "Calories"])
    }
    
    func setGestures() {
        coffeeDetailsView.setGestures()
    }
    
    func setReceiptText() {
        var recipeString = ""
        for (index, step) in recipe.enumerated() {
            recipeString.append("\(index + 1). \(step) \n\n")
        }
        
        coffeeDetailsView.setReceiptText(text: recipeString)
    }
    
    func setReceiptTextHeight(receiptViewOriginY: CGFloat, receiptTextOriginY: CGFloat, ingredientsTableViewHeight: CGFloat) {
        let controllerMaxY = UIScreen.main.bounds.height - fullViewOriginY
        let bottomSpace: CGFloat = 40.0
        let ingredientsTableTopBottomSpace: CGFloat = 14.0
        let receiptTopSpace: CGFloat = 17.0
        
        let textHeight = controllerMaxY - (receiptViewOriginY + ingredientsTableViewHeight + (2 * ingredientsTableTopBottomSpace) + receiptTopSpace + receiptTextOriginY) - bottomSpace
        
        coffeeDetailsView.setReceiptTextHeight(height: textHeight)
    }
    
    func setMLTabs() {
        coffeeDetailsView.setMLTabs(with: ["250 ml", "350 ml", "500 ml"])
    }
    
    func onLikeClicked() {
        coffeeService.setCoffeeFavourite(coffee: coffee)
        coffeeDetailsView.updateLikeButton(isLike: coffee.is_favourite, isAnimate: true)
    }
}


