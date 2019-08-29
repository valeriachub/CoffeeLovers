//
//  CoffeeCell.swift
//  CoffeeLovers
//
//  Created by Valeria on 29.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit


@IBDesignable
class CoffeeViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var coffeeTitle: UILabel!
    
    // MARK: - Methods
    
    func setCell(image: UIImage, title: String) {
        coffeeTitle.text = title
        coffeeImageView.image = image
    }
}
