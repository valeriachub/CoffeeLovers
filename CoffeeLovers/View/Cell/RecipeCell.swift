//
//  RecipeCell.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 28.04.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static func getCellForRow(indexPath: IndexPath, of tableView: UITableView, for text: String) -> RecipeCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecipeCell.self)", for: indexPath) as? RecipeCell else {
            fatalError()
        }
        
        cell.numberLabel.text = "\(indexPath.row + 1)"
        cell.descriptionLabel.text = text
        
        return cell
    }
    
}
