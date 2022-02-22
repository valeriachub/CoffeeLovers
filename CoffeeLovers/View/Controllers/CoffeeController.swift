//
//  CoffeeController.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/31/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

class CoffeeController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var crossView: UIView!
    
    // MARK: - Properties
    
    var configurator: CoffeeConfigurator?
    var presenter: CoffeePresenter!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configurator.configure(controller: self)
        presenter.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @objc
    func onCrossClicked() {
        presenter.onCrossClicked()
    }
}

extension CoffeeController: CoffeeDetailsDelegate {
    
    func bottomSheetOpen(isOpen: Bool, duration: Double) {
        if isOpen {
            self.darkView.isHidden = !isOpen
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, animations: {
            self.darkView.alpha = isOpen ? 0.4 : 0
        }) { _ in
            self.darkView.isHidden = !isOpen
        }
    }
}

extension CoffeeController: CoffeeView {
    
    func setCoffeeImage(imageTitle: String) {
        coffeeImageView.image = UIImage(named: imageTitle)
    }
    
    func setCoffeeDetails(with configurator: CoffeeDetailsConfigurator) {
        let coffeeDetails = CoffeeDetailsController()
        coffeeDetails.configurator = configurator
        coffeeDetails.delegate = self
        
        self.addChild(coffeeDetails)
        self.view.addSubview(coffeeDetails.view)
        coffeeDetails.didMove(toParent: self)
        
        let height = self.view.frame.height
        let width = self.view.frame.width
        
        coffeeDetails.view.frame = CGRect(x: 0, y: height - (height / 3) - 100, width: width, height: height)
    }
    
    func setCrossView() {
        crossView.layer.cornerRadius = crossView.frame.height / 2.0
        crossView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCrossClicked)))
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
