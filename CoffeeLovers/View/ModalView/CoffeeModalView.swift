//
//  CoffeeModalView.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 29.04.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

class CoffeeModalView: UIView {
    
    private var contentView: ModalView
    
    override init(frame: CGRect) {
        contentView = ModalView.loadFromNib()
        super.init(frame: frame)
        addContentView(contentView)
    }
    
    required init?(coder: NSCoder) {
        contentView = ModalView.loadFromNib()
        super.init(coder: coder)
        addContentView(contentView)
    }
    
    private func addContentView(_ contentView: ModalView) {
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
    
    func updateFavority(isLike: Bool) {
        contentView.updateFavority(isLike: isLike)
    }
    
    func setDelegate(_ delegate: ModalViewDelegate) {
        contentView.setDelegate(delegate)
    }
}
