//
//  UICollectionView+Extensions.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 31.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeCell<T>(cellClass: T.Type, indexPath: IndexPath) -> T where T: UICollectionViewCell {
        let id = String(describing: cellClass.self)
        return dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! T
    }
}
