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

    @IBOutlet weak var coffeeView: UIView!
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var coffeeTitle: UILabel!
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 20.0
        contentView.layer.masksToBounds = true
    }
    
    static func getCellForItemAt(indexPath: IndexPath, of collectionView: UICollectionView, with data: Coffee) -> CoffeeViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CoffeeViewCell.self)", for: indexPath) as? CoffeeViewCell else {
            fatalError("Error with CollectionViewCell")
        }
        
        cell.setCell(image: UIImage(named: data.imageOfIngredients ?? "") ?? UIImage(named: "c_americano")!, title: data.title ?? "")
        
        return cell
    }
    
    func setCell(image: UIImage, title: String) {
        coffeeTitle.text = title
        coffeeImageView.image = image
    }
}
