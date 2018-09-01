//
//  FavouriteViewController.swift
//  CoffeeLovers
//
//  Created by Valeria on 27.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

class FavouriteViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var coffeeList = [Coffee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(UINib(nibName: "CoffeeViewCell", bundle: nil), forCellWithReuseIdentifier: "CoffeeCell")
        
        loadTempData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffeeList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoffeeCell", for: indexPath) as? CoffeeViewCell
            else{
                fatalError("Error with CollectionViewCell")
        }
        
        let coffee = coffeeList[indexPath.row]
        
        guard let image = coffee.image
            else {
                fatalError("Error with coffee assets")
        }
        
//        cell.label.text = coffee.name
//        cell.image.image = image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2) - 8, height: (view.frame.size.width/2) - 8)
    }
    
    //MARK: - Temp methods
    
    func loadTempData(){
//        let espresso = Coffee(name: "Espresso", image: UIImage(named: "espresso")!)
//        let mocha = Coffee(name: "Mocha", image: UIImage(named: "mocha")!)
//        let latte = Coffee(name: "Latte", image: UIImage(named: "latte")!)
//        
//        coffeeList.append(espresso)
//        coffeeList.append(mocha)
//        coffeeList.append(latte)
    }

}
