//
//  ModalView.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 28.03.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

protocol ModalViewDelegate: NSObject {
    func likeButtonClicked()
}

class ModalView: UIView {
    
    @IBOutlet weak var bottomGradientView: UIView! {
        didSet {
            let gradient = CAGradientLayer()
            gradient.type = .axial
            gradient.colors = [UIColor.systemBackground.withAlphaComponent(0.0).cgColor,
                               UIColor.systemBackground.cgColor]
            gradient.locations = [0, 0.6]
            bottomGradientView.layer.addSublayer(gradient)
        }
    }
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var likeImageView: UIImageView! {
        didSet {
            likeImageView.image = likeImageView.image?.withRenderingMode(.alwaysTemplate)
            likeImageView.tintColor = .gray
            likeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeButtonClicked)))
        }
    }
    
    @IBOutlet private(set) weak var tableView: UITableView! {
        didSet {
            
            tableView.register(UINib(nibName: "\(IngredientCell.self)", bundle: nil), forCellReuseIdentifier: "\(IngredientCell.self)")
            tableView.register(UINib(nibName: "\(RecipeCell.self)", bundle: nil), forCellReuseIdentifier: "\(RecipeCell.self)")
            tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseIdentifier)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 500
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var ingredients = [String]()
    private var recipeSteps = [String]()
    
    private weak var delegate: ModalViewDelegate?
    
    static func loadFromNib() -> ModalView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "ModalView", bundle: bundle)
        return nib.instantiate(withOwner: nil).first as! ModalView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomGradientView.layer.sublayers?.first?.frame = bottomGradientView.bounds
    }
    
    @objc func likeButtonClicked() {
        likeImageView.tapAnimation()
        delegate?.likeButtonClicked()
    }
}

extension ModalView {
    
    func updateFavority(isLike: Bool) {
        likeImageView.tintColor = isLike ? .red : .gray
    }
    
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
    
    func setDelegate(_ delegate: ModalViewDelegate) {
        self.delegate = delegate
    }
}

extension ModalView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            return IngredientCell.getCellForRowAt(indexPath: indexPath, of: tableView, for: ingredients[indexPath.row])
            
        default:
            return RecipeCell.getCellForRow(indexPath: indexPath, of: tableView, for: recipeSteps[indexPath.row])
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return ingredients.count
        default: return recipeSteps.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view =  tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseIdentifier) as! SectionHeaderView
       
        switch section {
        case 0: view.set("Ingredients")
        default: view.set("Recipe")
        }
        
        return view
    }
}
