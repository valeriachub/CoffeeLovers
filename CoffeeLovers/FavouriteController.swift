//
//  FavouriteController.swift
//  CoffeeLovers
//
//  Created by Valeria on 9/5/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

class FavouriteController: CoffeeCollectionViewController {
    
    // MARK: - Properties
    
    var presenter: MainPresenter!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator = HomeConfigurator()
        configurator.configure(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        presenter.viewWillAppear(isFavouriteTab: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
}

// MARK: - Extension UICollectionViewController, UICollectionViewDelegateFlowLayout

extension FavouriteController {
    
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

extension FavouriteController: HomeView {
    
    func setPresenter(presenter: HomePresenter) {
        self.presenter = presenter
    }
    
    func performSegue(withIdentifier id: String) {
        performSegue(withIdentifier: id, sender: nil)
    }
    
    func reloadCollectionView() {
        collectionView?.reloadData()
    }
}
