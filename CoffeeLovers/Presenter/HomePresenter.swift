//
//  HomeViewPresenter.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/30/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

protocol HomeView: AnyObject {
    
    func setPresenter(presenter: HomePresenter)
    func performSegue(withIdentifier id: String)
    func reloadCollectionView()
}

class HomePresenter {
    
    // MARK: - Properties
    
    private var coffeeArray = [LocalCoffee]()
    var filteredCoffee = [LocalCoffee]() {
        didSet {
            homeView.reloadCollectionView()
        }
    }
    
    let homeRouter: HomeRouter!
    
    weak var homeView: HomeView!
    
    // MARK: - Init Methods
    
    init(coffeeArray: [LocalCoffee], view: HomeView, router: HomeRouter) {
        self.homeView = view
        self.homeRouter = router
        self.coffeeArray = coffeeArray
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        getCoffeeArray()
    }
    
    func viewWillAppear(isFavouriteTab: Bool = false) {
        getCoffeeArray(isFavouritesOnly: isFavouriteTab)
    }
    
    func getCoffeeArray(isFavouritesOnly: Bool = false) {
        filteredCoffee = coffeeArray.filter { $0.isFavourite == isFavouritesOnly }
    }
    
    func getNumberOfItemsInSection() -> Int {
        return filteredCoffee.count
    }
    
    func getCellForItemAt(indexPath: IndexPath, of collectionView: UICollectionView) -> CoffeeViewCell {
        return collectionView.dequeueReusableCell(for: indexPath)
    }
    
    func showCoffee(_ index: Int) {
        homeRouter.present(coffee: filteredCoffee[index])
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        homeRouter.prepare(for: segue, sender: sender)
    }
}
