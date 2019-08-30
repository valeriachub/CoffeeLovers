//
//  HomeViewController.swift
//  CoffeeLovers
//
//  Created by Valeria on 27.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    var presenter: HomeViewPresenter!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomeViewPresenter(view: self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let destination = segue.destination as? CoffeeViewController,
            let index = collectionView?.indexPathsForSelectedItems?.first?.row {
            
            destination.hidesBottomBarWhenPushed = true
            destination.coffee = presenter.coffeeArray[index]
        }
    }
}

// MARK: - Extension UICollectionViewController, UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getNumberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presenter.getCellForItemAt(indexPath: indexPath, of: collectionView)
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath : IndexPath) -> CGSize {
        return presenter.getSizeForCell(of: collectionView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCoffee", sender: self)
    }
}

// MARK: - Extension HomeView

extension HomeViewController: HomeView {
    
    func setCollectionView() {
        collectionView?.register(UINib(nibName: "\(CoffeeViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CoffeeViewCell.self)")
        collectionView?.collectionViewLayout = presenter.getFlowLayout()
    }
    
    func reloadCollectionView() {
        collectionView?.reloadData()
    }
}
