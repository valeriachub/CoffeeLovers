//
//  HomeViewPresenter.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/30/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit
import CoreData

protocol HomeView: NSObjectProtocol {
    
    func setCollectionView()
    func reloadCollectionView()
}

class HomeViewPresenter {
    
    // MARK: - Properties
    
    let sideSpacing: CGFloat = 16.0
    let itemsInRow: CGFloat = 2.0
    
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
        homeView.setCollectionView()
    }
    
    func getCoffeeArray() {
        coffeeArray = coffeeService.getCoffeeArray()
        homeView.reloadCollectionView()
    }
    
    func getNumberOfItemsInSection() -> Int {
        return coffeeArray.count
    }
    
    func getCellForItemAt(indexPath: IndexPath, of collectionView: UICollectionView) -> CoffeeViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CoffeeViewCell.self)", for: indexPath) as? CoffeeViewCell else {
            fatalError("Error with CollectionViewCell")
        }
        
        let coffee = coffeeArray[indexPath.row]
        cell.setCell(image: UIImage(named: coffee.imageOfIngredients ?? "") ?? UIImage(named: "c_americano")!, title: coffee.title ?? "")
        
        return cell
    }
    
    func getSizeForCell(of collectionView: UICollectionView) -> CGSize {
        let allSpacing = (2 * sideSpacing) + ( sideSpacing * (itemsInRow - 1))
        let width = (collectionView.bounds.width - CGFloat(allSpacing)) / itemsInRow
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func getFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: sideSpacing, left: sideSpacing, bottom: sideSpacing, right: sideSpacing)
        layout.minimumLineSpacing = sideSpacing
        layout.minimumInteritemSpacing = sideSpacing
        
        return layout
    }
}
