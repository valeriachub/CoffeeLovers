//
//  ImageView+Ext.swift
//  CoffeeLovers
//
//  Created by Valeria on 9/5/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func changeColor(on color: UIColor) {
        let image = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = image
        self.tintColor = color
    }
}
