//
//  CollectionTabNavigationController.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 31.03.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

public class CollectionTabNavigationController: UINavigationController {
    
    var selection: ((Coffee) -> Void)?
    
    init(rootViewController: UIViewController, image: UIImage, tag: Int) {
        super.init(rootViewController: rootViewController)
        isNavigationBarHidden = true
        tabBarItem = UITabBarItem(title: nil, image: image, tag: tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
