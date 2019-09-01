//
//  BottomSheetViewController.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/31/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tabsView: UIView!
    
    var tabsControl: TabsControl!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setTabs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        animView()
    }
    
    // MARK: - Methods
    
    func animView() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let y = UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 2.0) - 20
            self?.view.frame = CGRect(x: 0, y: y, width: frame!.width, height: frame!.height)
        }
    }
    
    func setViews() {
        topView.layer.cornerRadius = 30.0
    }
    
    func setTabs() {
        tabsControl = TabsControl(frame: tabsView.bounds, buttonTitles: ["Receipt", "Calories"])
        tabsControl.backgroundColor = .clear
        tabsView.addSubview(tabsControl)
        
        tabsControl.translatesAutoresizingMaskIntoConstraints = false
        
        tabsControl.topAnchor.constraint(equalTo: tabsView.topAnchor).isActive = true
        tabsControl.bottomAnchor.constraint(equalTo: tabsView.bottomAnchor).isActive = true
        tabsControl.leftAnchor.constraint(equalTo: tabsView.leftAnchor).isActive = true
        tabsControl.rightAnchor.constraint(equalTo: tabsView.rightAnchor).isActive = true
    }
}
