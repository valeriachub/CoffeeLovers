//
//  CoffeeCollectionViewController.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/31/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

public class CoffeeCollectionViewController: UICollectionViewController, CoffeeCollectionView {
    
    private let sideSpacing: CGFloat = 16.0
    private let itemsInRow: CGFloat = 2.0
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: sideSpacing, left: sideSpacing, bottom: sideSpacing, right: sideSpacing)
        layout.minimumLineSpacing = sideSpacing
        layout.minimumInteritemSpacing = sideSpacing
        return layout
    }()
    
    var presenter: CoffeeCollectionPresenter!
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "\(CoffeeViewCell.self)", bundle: nil),
                                forCellWithReuseIdentifier: "\(CoffeeViewCell.self)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.reloadData()
    }
    
}

extension CoffeeCollectionViewController {
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CoffeeViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setCell(image: UIImage(named: presenter.image(for: indexPath))!,
                     title: presenter.title(for: indexPath))
        return cell
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectItemAt(indexPath)
    }
}

extension CoffeeCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let allSpacing = (2 * sideSpacing) + ( sideSpacing * (itemsInRow - 1))
        let width = (collectionView.bounds.width - CGFloat(allSpacing)) / itemsInRow
        let height = width
        
        return CGSize(width: width, height: height)
    }
}
