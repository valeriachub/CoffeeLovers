//
//  HomeViewPresenter.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/30/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

protocol HomeView: NSObjectProtocol {
    
    func reloadCollectionView()
}

class HomeViewPresenter {
    
    // MARK: - Properties
    
    var coffeeArray = [Coffee]()
    var coffeeService = CoffeeDataService.shared
    
    weak var homeView: HomeView!
    
    // MARK: - Init Methods
    
    init(view: HomeView) {
        self.homeView = view
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
}
