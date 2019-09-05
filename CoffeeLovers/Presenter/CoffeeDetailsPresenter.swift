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
    var ingredients = ["Ice cream", "Coffee"]
    var partialViewOriginY: CGFloat {
        return UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 3) - 100
    }
    
    weak var coffeeDetailsView: CoffeeDetailsView!
    
    // MARK: - Init Methods
    
    init(view: CoffeeDetailsView, coffee: Coffee) {
        self.coffeeDetailsView = view
        self.coffee = coffee
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
        return IngredientCell.getCellForRowAt(indexPath: indexPath, of: tableView, for: coffee)
    }
    
    func setCoffee() {
        coffeeDetailsView.setCoffeeTitle(title: coffee.title ?? "")
        coffeeDetailsView.updateLikeButton(isLike: coffee.isFavourite, isAnimate: false)
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
        coffeeDetailsView.setReceiptText(text: "Lorem ipsum — dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.[1] Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum — dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.[1] Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum — dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.[1] Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
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
        coffeeDetailsView.updateLikeButton(isLike: coffee.isFavourite, isAnimate: true)
    }
}


