//
//  FavouriteController.swift
//  CoffeeLovers
//
//  Created by Valeria on 9/5/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

public class FavouriteController: CoffeeCollectionViewController, MainView {
    
    var presenter: MainPresenter!
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.favouriteCoffeeCount
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CoffeeViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setCell(image: UIImage(named: presenter.image(for: indexPath))!, title: presenter.title(for: indexPath))
        return cell
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        presenter.showCoffee(indexPath.row)
    }
}
