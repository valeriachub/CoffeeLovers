//
//  ModalView.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 28.03.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

class ModalView: UIView {
    
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var tableView: UITableView! {
        didSet {
            
            tableView.register(UINib(nibName: "\(IngredientCell.self)", bundle: nil), forCellReuseIdentifier: "\(IngredientCell.self)")
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var ingredients = [String]()
    private var recipeSteps = [String]()
    
    static func loadFromNib() -> ModalView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "ModalView", bundle: bundle)
        return nib.instantiate(withOwner: nil).first as! ModalView
    }
}

extension ModalView {
    
    func updateTitleLabel(with text: String) {
        titleLabel.text = text
    }
    
    func updateDescriptionLabel(with text: String) {
        descriptionLabel.text = text
    }
    
    func updateRecipe(ingredients: [String], steps: [String]) {
        self.ingredients = ingredients
        recipeSteps = steps
    }
}

extension ModalView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            return IngredientCell.getCellForRowAt(indexPath: indexPath, of: tableView, for: ingredients[indexPath.row])
            
        default:
            return IngredientCell.getCellForRowAt(indexPath: indexPath, of: tableView, for: ingredients[indexPath.row])

            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return ingredients.count
        default: return ingredients.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Ingredients"
        default: return "Recipe"
        }
    }
}

class CoffeeModalView: UIView {
    
    private var contentView: ModalView
    
    override init(frame: CGRect) {
        contentView = ModalView.loadFromNib()
        super.init(frame: frame)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        contentView = ModalView.loadFromNib()
        super.init(coder: coder)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func updateTitleLabel(with text: String) {
        contentView.updateTitleLabel(with: text)
    }
    
    func updateDescriptionLabel(with text: String) {
        contentView.updateDescriptionLabel(with: text)
    }
    
    func updateRecipe(ingredients: [String], steps: [String]) {
        contentView.updateRecipe(ingredients: ingredients, steps: steps)
    }
}
