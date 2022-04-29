//
//  Coffee.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 29.04.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import Foundation

public class Coffee {
    let title: String
    let image: String
    var isFavourite: Bool
    let descriptions: String
    let ingredients: [String]
    let recipeSteps: [String]
    
    init(title: String, image: String, isFavourite: Bool, descriptions: String, ingredients: [String], recipeSteps: [String]) {
        self.title = title
        self.image = image
        self.isFavourite = isFavourite
        self.descriptions = descriptions
        self.ingredients = ingredients
        self.recipeSteps = recipeSteps
    }
}
