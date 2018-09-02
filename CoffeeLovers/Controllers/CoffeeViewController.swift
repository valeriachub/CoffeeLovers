//
//  CoffeeViewController.swift
//  CoffeeLovers
//
//  Created by Valeria on 28.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

class CoffeeViewController: UIViewController {
    
    @IBOutlet weak var imageCoffee: UIImageView!
    @IBOutlet weak var ingredientsView: IngredientsView!
    @IBOutlet weak var sizeSegment: UISegmentedControl!
    
    var coffee : Coffee?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = coffee?.image else {
            fatalError("Error with Coffee assets")
        }
        
        imageCoffee.image = UIImage(named: image)
        title = coffee?.title
        
        ingredientsView.coffee = coffee
        ingredientsView.layer.cornerRadius = 10.0
        ingredientsView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        ingredientsView.layer.borderWidth = 1.0
        
//        sizeSegment.subviews[0].
        
//        (sizeSegment.subviews[2] as! UIImageView).frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        
    }
}
