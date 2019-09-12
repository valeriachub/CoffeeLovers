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
    func setCornerRadius(_ radius: CGFloat)
    func setTableView(rowHeight: CGFloat, tableHeight: CGFloat)
    func setTabs(with titles: [String])
    func setGestures()
    func setReceiptText(text: String)
    func setReceiptTextHeight(height: CGFloat)
    func setMLTabs(with titles: [String])
    func updateLikeButton(isLike: Bool, isAnimate: Bool)
    func setCaloriesLabel(with value: Double, isSolo: Bool)
}

class CoffeeDetailsPresenter {
    
    // MARK: - Properties
    
    private let coffeeService = CoffeeDataService.shared
    private let cornerRadius: CGFloat = 30.0
    private let rowHeight: CGFloat = 30.0
    let fullViewOriginY: CGFloat = 130.0
    
    private var coffee: Coffee!
    private var ingredients: [String]
    private var recipe: [String]
    private var caloriesSize: CaloriesSize!
    private var caloriesSolo: Double = 0
    
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
        self.caloriesSize = coffee.calories_size
        self.caloriesSolo = coffee.calories_solo
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
        if caloriesSolo <= 0 {
            coffeeDetailsView.setMLTabs(with: ["250 ml", "350 ml", "500 ml"])
            coffeeDetailsView.setCaloriesLabel(with: getCaloriesFor(index: 0), isSolo: false)
        } else {
            coffeeDetailsView.setCaloriesLabel(with: caloriesSolo, isSolo: true)
        }
    }
    
    func getCaloriesFor(index: Int) -> Double {
        switch index {
        case 0:
            return caloriesSize.s
        case 1:
            return caloriesSize.m
        case 2:
            return caloriesSize.l
        default:
            return 0
        }
    }
    
    func onLikeClicked() {
        coffeeService.setCoffeeFavourite(coffee: coffee)
        coffeeDetailsView.updateLikeButton(isLike: coffee.is_favourite, isAnimate: true)
    }
}


