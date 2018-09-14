//
//  HomeViewController.swift
//  CoffeeLovers
//
//  Created by Valeria on 27.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var coffeeArray = [Coffee]()
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(UINib(nibName: "CoffeeViewCell", bundle: nil), forCellWithReuseIdentifier: "CoffeeCell")
        
        loadCoffee()
    }
    
    //MARK: - Data Model methods
    
    func loadCoffee(){
        let request : NSFetchRequest<Coffee> = Coffee.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        do {
            coffeeArray = try context.fetch(request)
        }catch {
            print("Error Load Coffee Data")
        }
    }
    
    //MARK: - UICollectionView SourceData methods
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffeeArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoffeeCell", for: indexPath) as? CoffeeViewCell
            else {fatalError("Error with CollectionViewCell")}
        
        let coffee = coffeeArray[indexPath.row]
        
        guard let image = coffee.imageOfIngredients else {fatalError("Error with coffee assets")}
        
        cell.label.text = coffee.title
        cell.image.image = UIImage(named: image)
        
        return cell
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath : IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2)-0.5, height: (view.frame.size.width/2)-1)
    }
    
    // MARK: - Navigation Methods
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCoffee", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CoffeeViewController
        
        destination.hidesBottomBarWhenPushed = true
        
        if let index = collectionView?.indexPathsForSelectedItems?.first?.row {
            destination.coffee = coffeeArray[index]
        }
    }
}
