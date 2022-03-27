//
//  CoffeeController.swift
//  CoffeeLovers
//
//  Created by Valeria on 8/31/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

class CoffeeController: UIViewController {
        
    @IBOutlet weak var coffeeImageView: UIImageView!
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    var configurator: CoffeeConfigurator?
    var presenter: CoffeePresenter!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.setTitle("", for: .normal)
        presenter.setViews()
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        presenter.closeAction()
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
    
    func setImage(title: String) {
        coffeeImageView.image = UIImage(named: title)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
