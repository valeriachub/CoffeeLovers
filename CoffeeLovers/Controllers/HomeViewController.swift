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
    
    var coffeeArray = [Coffee]()
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        loadCoffee()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if
            let destination = segue.destination as? CoffeeViewController,
            let index = collectionView?.indexPathsForSelectedItems?.first?.row {
            
            destination.hidesBottomBarWhenPushed = true
            destination.coffee = coffeeArray[index]
        }
    }
    
    // MARK: - Methods
    
    func setCollectionView() {
        
        collectionView?.register(UINib(nibName: "\(CoffeeViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CoffeeViewCell.self)")
    }
    
    func loadCoffee() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Coffee> = Coffee.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        do {
            coffeeArray = try context.fetch(request)
        } catch {
            print("Error Load Coffee Data")
        }
    }
}

// MARK: - Extension UICollectionViewController, UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return coffeeArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CoffeeViewCell.self)", for: indexPath) as? CoffeeViewCell else {
            fatalError("Error with CollectionViewCell")
        }
        
        let coffee = coffeeArray[indexPath.row]
        cell.setCell(image: UIImage(named: coffee.imageOfIngredients ?? "") ?? UIImage(named: "c_americano")!, title: coffee.title ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath : IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.size.width / 2.0) - 0.5, height: (view.frame.size.width / 2.0) - 1)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showCoffee", sender: self)
    }
}
