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
    @IBOutlet weak var dimmedView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        return view
    }()
    
    lazy var coffeeDescriptionModalView: CoffeeModalView = {
        let view = CoffeeModalView()
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    
    let defaultHeight: CGFloat = UIScreen.main.bounds.height / 3 + 100
    let dismissableHeight: CGFloat = UIScreen.main.bounds.height / 2
    let maxContainerHeight: CGFloat = UIScreen.main.bounds.height - 40 - 80
    var currentContainerHeight: CGFloat = UIScreen.main.bounds.height / 3 + 100
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    var presenter: CoffeePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupConstraints()
        setupPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateContainerView()
    }
    
    private func setupConstraints() {
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
        containerView.addSubview(coffeeDescriptionModalView)
        coffeeDescriptionModalView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            coffeeDescriptionModalView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            coffeeDescriptionModalView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            coffeeDescriptionModalView.topAnchor.constraint(equalTo: containerView.topAnchor),
            coffeeDescriptionModalView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        
    }
    
    private func animateContainerView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.containerView.shakeMe()
        }
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let yPoint = gesture.translation(in: view).y
        let isDraggingDown = yPoint > 0
        
        let newHeight = currentContainerHeight - yPoint
        
        switch gesture.state {
        case .changed:
            if newHeight < maxContainerHeight && newHeight > defaultHeight {
                containerViewHeightConstraint?.constant = newHeight
                containerView.layoutIfNeeded()
            }
            
        case .ended:
            if newHeight < dismissableHeight {
                animateContainerHeight(with: defaultHeight)
            } else if newHeight < maxContainerHeight && isDraggingDown {
                animateContainerHeight(with: defaultHeight)
            } else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(with: maxContainerHeight)
            }
            
        default: break
            
        }
        
    }
    
    private func animateContainerHeight(with height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        
        currentContainerHeight = height
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        presenter.closeAction()
    }
}

extension CoffeeController: CoffeeView {
    func display(viewModel: CoffeeViewModel) {
        coffeeImageView.image = UIImage(named: viewModel.imageTitle)
        
        coffeeDescriptionModalView.updateTitleLabel(with: viewModel.title)
        coffeeDescriptionModalView.updateDescriptionLabel(with: viewModel.description)
        
        let ingredients = viewModel.ingredients
        let recipeSteps = viewModel.recipe
        
        coffeeDescriptionModalView.updateRecipe(ingredients: ingredients, steps: recipeSteps)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension UIView {
    
    func shakeMe() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        animation.duration = 0.9
        animation.values = [0, 10, -10, 5, -5, 0]
        layer.add(animation, forKey: "shake")
    }
}
