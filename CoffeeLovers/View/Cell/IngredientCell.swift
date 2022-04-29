//
//  IngredientCell.swift
//  CoffeeLovers
//
//  Created by Valeria on 9/1/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dotView: UIView! {
        didSet {
            dotView.layer.cornerRadius = dotView.bounds.width / 2
        }
    }
        
    static func getCellForRowAt(indexPath: IndexPath, of tableView: UITableView, for ingredient: String) -> IngredientCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(IngredientCell.self)", for: indexPath) as? IngredientCell else {
            fatalError()
        }
        
        cell.setTitle(title: ingredient)
        
        return cell
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
}
