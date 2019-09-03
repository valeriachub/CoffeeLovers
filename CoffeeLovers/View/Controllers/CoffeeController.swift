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
    
    // MARK: - Properties
    
    var configurator: CoffeeConfigurator!
    var presenter: CoffeePresenter!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(controller: self)
        presenter.viewDidLoad()
    }
}

extension CoffeeController: CoffeeDetailsDelegate {
    func bottomSheetOpen(isOpen: Bool, duration: Double) {
        
        UIView.animate(withDuration: duration, delay: 0.0, animations: {
            self.darkView.alpha = isOpen ? 0.4 : 0
        })
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
        
        self.addChildViewController(coffeeDetails)
        self.view.addSubview(coffeeDetails.view)
        coffeeDetails.didMove(toParentViewController: self)
        
        let height = self.view.frame.height
        let width = self.view.frame.width
        
        coffeeDetails.view.frame = CGRect(x: 0, y: height - (height / 3) - 100, width: width, height: height)
    }
}
