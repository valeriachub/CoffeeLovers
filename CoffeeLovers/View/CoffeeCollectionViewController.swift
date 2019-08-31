//
//  CoffeeCollectionViewController.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/31/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

class CoffeeCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    let sideSpacing: CGFloat = 16.0
    let itemsInRow: CGFloat = 2.0
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(UINib(nibName: "\(CoffeeViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CoffeeViewCell.self)")
        collectionView?.collectionViewLayout = getFlowLayout()
    }
    
    // MARK: - Methods
    
    func getFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: sideSpacing, left: sideSpacing, bottom: sideSpacing, right: sideSpacing)
        layout.minimumLineSpacing = sideSpacing
        layout.minimumInteritemSpacing = sideSpacing
        
        return layout
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout

extension CoffeeCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let allSpacing = (2 * sideSpacing) + ( sideSpacing * (itemsInRow - 1))
        let width = (collectionView.bounds.width - CGFloat(allSpacing)) / itemsInRow
        let height = width
        
        return CGSize(width: width, height: height)
    }
}
