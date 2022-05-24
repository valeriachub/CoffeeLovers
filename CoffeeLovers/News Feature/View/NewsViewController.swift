//
//  NewsViewController.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 30.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

class NewsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let sideSpacing: CGFloat = 16.0
    private let itemsInRow: CGFloat = 1.0
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: sideSpacing, left: sideSpacing, bottom: sideSpacing, right: sideSpacing)
        layout.minimumLineSpacing = sideSpacing
        layout.minimumInteritemSpacing = sideSpacing
        return layout
    }()
    private lazy var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        return refreshControl
    }()
    
    var presenter: NewsPresenter!
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
        collectionView.collectionViewLayout = layout
        collectionView.refreshControl = refreshControl
        collectionView.register(UINib(nibName: "\(NewsCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(NewsCell.self)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let item = presenter.item(for: indexPath),
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(NewsCell.self)", for: indexPath) as? NewsCell else {
                return UICollectionViewCell()
            }
        cell.setup(with: item)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let allSpacing = (2 * sideSpacing) + itemsInRow
        let width = collectionView.bounds.width - CGFloat(allSpacing)
        let height: CGFloat = 200
        
        return CGSize(width: width, height: height)
    }
}

extension NewsViewController {
    @objc private func refreshControlAction() {
        refreshControl.beginRefreshing()
        presenter.loadNews()
    }
}

extension NewsViewController: NewsView {
    
    func updateNews(_ news: [NewsItem]) {
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }
}
