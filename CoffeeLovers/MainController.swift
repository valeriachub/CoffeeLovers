//
//  MainController.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 22.02.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

protocol MainView {
    
    
}

public class MainPresenter {
    
    private let localCoffee: [LocalCoffee]
    private let view: MainView
    
    init(localCoffee: [LocalCoffee], view: MainView) {
        self.localCoffee = localCoffee
        self.view = view
    }
    
    func image(for indexPath: IndexPath) -> String {
        return localCoffee[indexPath.item].image
    }
    
    func title(for indexPath: IndexPath) -> String {
        return localCoffee[indexPath.item].title
    }
    
    var mainCoffeeCount: Int {
        return localCoffee.count
    }
    
    var favouriteCoffeeCount: Int {
        return localCoffee.filter { $0.isFavourite }.count
    }
    
}

public class MainController: CoffeeCollectionViewController, MainView {
    
    var presenter: MainPresenter!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.mainCoffeeCount
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CoffeeViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setCell(image: UIImage(named: presenter.image(for: indexPath))!, title: presenter.title(for: indexPath))
        return cell
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for index: IndexPath) -> T {
        let identifier = String.init(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: index) as! T
    }
}
