//
//  MainNavigationController.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/4/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

       interactivePopGestureRecognizer?.delegate = self
    }
    
    // MARK: - Methods
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let lastViewController = viewControllers.last {
            if lastViewController.presentedViewController != nil {
                return false
            }
        }
        return viewControllers.count > 1
    }
}
