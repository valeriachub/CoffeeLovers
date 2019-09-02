//
//  HomeViewPresenter.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/30/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

protocol HomeView: class {
    
    func reloadCollectionView()
}

class HomeViewPresenter {
    
    // MARK: - Properties
    
    var coffeeArray = [Coffee]()
    
    let coffeeService = CoffeeDataService.shared
    let homeRouter: HomeRouter!
    
    weak var homeView: HomeView!
    
    // MARK: - Init Methods
    
    init(view: HomeView, router: HomeRouter) {
        self.homeView = view
        self.homeRouter = router
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        getCoffeeArray()
    }
    
    func getCoffeeArray() {
        coffeeArray = coffeeService.getCoffeeArray()
        homeView.reloadCollectionView()
    }
    
    func getNumberOfItemsInSection() -> Int {
        return coffeeArray.count
    }
    
    func getCellForItemAt(indexPath: IndexPath, of collectionView: UICollectionView) -> CoffeeViewCell {
        return CoffeeViewCell.getCellForItemAt(indexPath: indexPath, of: collectionView, with: coffeeArray[indexPath.row])
    }
    
    func showCoffee(_ index: Int) {
        homeRouter.present(coffee: coffeeArray[index])
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        homeRouter.prepare(for: segue, sender: sender)
    }
}
