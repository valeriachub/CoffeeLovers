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
    @IBOutlet weak var ingredientsTableViewHeight: NSLayoutConstraint!
    
    let ingredients = ["Coffee", "Ice Cream"]
    
    weak var delegate: CoffeeDetailsDelegate?
    
    var configurator: CoffeeDetailsConfigurator!
    var presenter: CoffeeDetailsPresenter!
    
    let fullViewHeight: CGFloat = 130
    var partialViewHeight: CGFloat {
        return UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 3) - 100 
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(controller: self)
        presenter.viewDidLoad()
    }
    
    func setViews() {
        topView.layer.cornerRadius = 30.0
    }
    
    func setTabs() {
        let tabsControl = TabsControl(frame: tabsView.bounds, buttonTitles: ["Receipt", "Calories"], delegate: self)
        tabsControl.backgroundColor = .clear
        tabsView.addSubview(tabsControl)
        
        tabsControl.translatesAutoresizingMaskIntoConstraints = false
        
        tabsControl.topAnchor.constraint(equalTo: tabsView.topAnchor).isActive = true
        tabsControl.bottomAnchor.constraint(equalTo: tabsView.bottomAnchor).isActive = true
        tabsControl.leftAnchor.constraint(equalTo: tabsView.leftAnchor).isActive = true
        tabsControl.rightAnchor.constraint(equalTo: tabsView.rightAnchor).isActive = true
    }
    
    private func setTableView() {
        ingredientsTableView.register(UINib(nibName: "\(IngredientCell.self)", bundle: nil), forCellReuseIdentifier: "\(IngredientCell.self)")
        ingredientsTableView.rowHeight = 30
        ingredientsTableView.dataSource = self
        ingredientsTableViewHeight.constant = CGFloat(30 * ingredients.count)
    }
    
    private func setGesture() {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onPanGesture(_:))))
    }
    
    @objc
    func onPanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let viewY = view.frame.minY
        
        if (fullViewHeight...partialViewHeight).contains(viewY + translation.y) {
            view.frame.origin.y = viewY + translation.y
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
        
        if recognizer.state == .ended {
            let velocity = recognizer.velocity(in: view)
            
            var duration = velocity.y < 0 ?
                Double((viewY - fullViewHeight) / -velocity.y) :
                Double((partialViewHeight - viewY) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                self.view.frame.origin.y = velocity.y >= 0 ? self.partialViewHeight : self.fullViewHeight
            })
            
            delegate?.bottomSheetOpen(isOpen: velocity.y < 0, duration: duration)
        }
    }
}

extension CoffeeDetailsController: TabsControlDelegate {
    
    func onTabClicked(index: Int) {
        print(index)
    }
}

extension CoffeeDetailsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(IngredientCell.self)", for: indexPath) as? IngredientCell else {
            fatalError()
        }
        
        cell.setIngredienTitle(ingredients[indexPath.row])
        
        return cell
    }
}

extension CoffeeDetailsController: CoffeeDetailsView {
    func setCoffeeTitle(title: String) {
        
        titleLabel.text = title
        
        setViews()
        setTabs()
        setTableView()
        setGesture()
    }
    
    
}
