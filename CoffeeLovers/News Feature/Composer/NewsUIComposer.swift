//
//  NewsUIComposer.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 30.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import Foundation
import UIKit

class NewsUIComposer {
    
    static func compose(with image: UIImage, tag: Int) -> UIViewController {
        let controller = NewsViewController()
        controller.tabBarItem = UITabBarItem(title: nil, image: image, tag: tag)
        let loader = FirebaseNewsLoader()
        let presenter = NewsPresenter(view: WeakWrapper(controller), loader: loader)
        controller.presenter = presenter
        presenter.loadNews()
        
        return controller
    }
}
