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
    
    var coffee : Coffee?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = coffee?.image else {
            fatalError("Error with Coffee assets")
        }
        
        imageCoffee.image = UIImage(named: image)
        title = coffee?.title
    }
}
