//
//  UIView+Extensions.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 29.04.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

extension UIView {
    
    func shakeMe() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        animation.duration = 0.9
        animation.values = [0, 10, -10, 5, -5, 0]
        layer.add(animation, forKey: "shake")
    }
    
    func tapAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        animation.duration = 0.2
        animation.values = [0.8, 1]
        layer.add(animation, forKey: "tapScale")
    }
}
