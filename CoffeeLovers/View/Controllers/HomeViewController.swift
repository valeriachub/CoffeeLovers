//
//  HomeViewController.swift
//  CoffeeLovers
//
//  Created by Valeria on 27.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

class HomeViewController: CoffeeCollectionViewController {
    
    // MARK: - Properties
    
    var presenter: HomeViewPresenter!
    var configurator: HomeConfigurator!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator = HomeConfigurator()
        configurator.configure(controller: self)
        
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
}

// MARK: - Extension UICollectionViewController, UICollectionViewDelegateFlowLayout

extension HomeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getNumberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presenter.getCellForItemAt(indexPath: indexPath, of: collectionView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showCoffee(indexPath.row)
    }
}

// MARK: - Extension HomeView

extension HomeViewController: HomeView {
    
    func reloadCollectionView() {
        collectionView?.reloadData()
    }
}
