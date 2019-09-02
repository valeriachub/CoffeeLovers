//
//  IngredientCell.swift
//  CoffeeLovers
//
//  Created by Valeria on 9/1/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dotView.layer.cornerRadius = dotView.bounds.width / 2
    }
    
    func setIngredienTitle(_ title: String) {
        titleLabel.text = title
    }
}
