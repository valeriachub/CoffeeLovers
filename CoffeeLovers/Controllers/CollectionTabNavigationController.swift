//
//  CollectionTabNavigationController.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 31.03.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

public class CollectionTabNavigationController: UINavigationController {
    
    var selection: ((LocalCoffee) -> Void)?
    
    init(rootViewController: UIViewController, imageName: String, tag: Int) {
        super.init(rootViewController: rootViewController)
        isNavigationBarHidden = true
        tabBarItem = UITabBarItem(title: nil, image: UIImage(named: imageName)!, tag: tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
