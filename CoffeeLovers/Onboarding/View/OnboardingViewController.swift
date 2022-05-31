//
//  OnboardingViewController.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 31.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButtonView: UIButton!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "\(OnboardingCell.self)", bundle: nil), forCellWithReuseIdentifier: OnboardingCell.identifier)
        }
    }
    
    private var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            
            if currentPage == presenter.numberOfItems - 1 {
                nextButtonView.setTitle("Get Started", for: .normal)
            } else {
                nextButtonView.setTitle("Next", for: .normal)
            }
        }
    }
    private let presenter: OnboardingPresenter
    private let getStartedCallback: (() -> Void)?
    
    init(presenter: OnboardingPresenter, getStartedCallback: @escaping(() -> Void)) {
        self.presenter = presenter
        self.getStartedCallback = getStartedCallback
        super.init(nibName: "\(OnboardingViewController.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        guard currentPage < presenter.numberOfItems - 1 else {
            getStartedCallback?()
            return
        }
        
        currentPage += 1
        let index = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = presenter.getItem(for: indexPath) else {
            return UICollectionViewCell()
        }
        let cell: OnboardingCell = collectionView.dequeCell(cellClass: OnboardingCell.self, indexPath: indexPath)
        cell.setup(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
