//
//  BottomSheetViewController.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/31/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

protocol CoffeeDetailsDelegate: class {
    func bottomSheetOpen(isOpen: Bool, duration: Double)
}

class CoffeeDetailsController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tabsView: UIView!
    @IBOutlet weak var receiptView: UIView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var receiptTextView: UITextView!
    @IBOutlet weak var ingredientsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var receiptTextHeight: NSLayoutConstraint!
    @IBOutlet weak var receiptTextContainerView: UIView!
    @IBOutlet weak var caloriesView: UIView!
    @IBOutlet weak var mlView: UIView!
    @IBOutlet weak var caloriesLabelView: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    
    // MARK: - Properties
    
    weak var delegate: CoffeeDetailsDelegate?
    
    var configurator: CoffeeDetailsConfigurator!
    var presenter: CoffeeDetailsPresenter!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(controller: self)
        presenter.viewDidLoad()
        presenter.setReceiptTextHeight(receiptViewOriginY: receiptView.frame.origin.y,
                                       receiptTextOriginY: receiptTextView.frame.origin.y,
                                       ingredientsTableViewHeight: ingredientsTableViewHeight.constant)
    }
    
    // MARK: - Actions
    
    @objc
    func onPanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let viewY = view.frame.minY
        
        if (presenter.fullViewOriginY...presenter.partialViewOriginY).contains(viewY + translation.y) {
            view.frame.origin.y = viewY + translation.y
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
        
        if recognizer.state == .ended {
            let velocity = recognizer.velocity(in: view)
            
            var duration = velocity.y < 0 ?
                Double((viewY - presenter.fullViewOriginY) / -velocity.y) :
                Double((presenter.partialViewOriginY - viewY) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                self.view.frame.origin.y = velocity.y >= 0 ? self.presenter.partialViewOriginY : self.presenter.fullViewOriginY
            })
            
            delegate?.bottomSheetOpen(isOpen: velocity.y < 0, duration: duration)
        }
    }
    
    @objc
    func onLikeClicked() {
        print("clicked")
    }
}

// MARK: - Extension TabsControlDelegate

extension CoffeeDetailsController: TabsControlDelegate {
    
    func onTabClicked(index: Int) {
        showTab(index: index)
    }
}

// MARK: - Extension MLControlDelegate

extension CoffeeDetailsController: MLControlDelegate {
    
    func onMLTabClicked(index: Int) {
        switch index {
        case 0: caloriesLabelView.text = "300"
        case 1: caloriesLabelView.text = "340"
        case 2: caloriesLabelView.text = "400"
        default:
            print(index)
        }
    }
}

// MARK: - Extension UITableViewDataSource

extension CoffeeDetailsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRowsIngredients()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.getCellForIngredientRow(at: indexPath, of: tableView)
    }
}

// MARK: - Extension CoffeeDetailsView

extension CoffeeDetailsController: CoffeeDetailsView {
    
    func setCoffeeTitle(title: String) {
        titleLabel.text = title
    }
    
    func setCornerRadius(_ radius: CGFloat) {
        topView.layer.cornerRadius = radius
    }
    
    func setTableView(rowHeight: CGFloat, tableHeight: CGFloat) {
        ingredientsTableView.register(UINib(nibName: "\(IngredientCell.self)", bundle: nil), forCellReuseIdentifier: "\(IngredientCell.self)")
        
        ingredientsTableView.dataSource = self
        
        ingredientsTableView.rowHeight = rowHeight
        ingredientsTableViewHeight.constant = tableHeight
    }
    
    func setTabs(with titles: [String]) {
        let tabsControl = TabsControl(frame: tabsView.bounds, buttonTitles: titles, delegate: self)
        tabsControl.backgroundColor = .clear
        tabsView.addSubview(tabsControl)
        
        tabsControl.translatesAutoresizingMaskIntoConstraints = false
        
        tabsControl.topAnchor.constraint(equalTo: tabsView.topAnchor).isActive = true
        tabsControl.bottomAnchor.constraint(equalTo: tabsView.bottomAnchor).isActive = true
        tabsControl.leftAnchor.constraint(equalTo: tabsView.leftAnchor).isActive = true
        tabsControl.rightAnchor.constraint(equalTo: tabsView.rightAnchor).isActive = true
        
        showTab(index: 0)
    }
    
    func showTab(index: Int) {
        receiptView.isHidden = index != 0
        caloriesView.isHidden = index != 1
    }
    
    func setGestures() {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onPanGesture(_:))))
        likeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLikeClicked)))
    }
    
    func setReceiptText(text: String) {
        receiptTextView.text = text
    }
    
    func setReceiptTextHeight(height: CGFloat) {
        receiptTextHeight.constant = height
    }
    
    func setMLTabs(with titles: [String]) {
        let mlControl = MLControl(frame: mlView.bounds, buttonTitles: titles, delegate: self)
        mlControl.backgroundColor = .clear
        mlView.addSubview(mlControl)
        
        mlControl.translatesAutoresizingMaskIntoConstraints = false
        
        mlControl.topAnchor.constraint(equalTo: mlView.topAnchor).isActive = true
        mlControl.bottomAnchor.constraint(equalTo: mlView.bottomAnchor).isActive = true
        mlControl.leftAnchor.constraint(equalTo: mlView.leftAnchor).isActive = true
        mlControl.rightAnchor.constraint(equalTo: mlView.rightAnchor).isActive = true
    }
}
