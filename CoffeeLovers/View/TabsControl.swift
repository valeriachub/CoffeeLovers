//
//  TabsControl.swift
//  CoffeeLovers
//
//  Created by Valeria on 9/1/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

class TabsControl: UIView {
    
    // MARK: - Properties
    
    private var buttonTitles = ["Receipt", "Calories"]
    private var buttons = [UIButton]()
    private var selectorView: UIView!
    private var tabWidth: CGFloat {
        return self.bounds.width / CGFloat(buttons.count)
    }
    
    var normalColor = #colorLiteral(red: 0.4431372549, green: 0.462745098, blue: 0.4784313725, alpha: 1)
    var selectedColor = #colorLiteral(red: 0.9725490196, green: 0.1450980392, blue: 0.2901960784, alpha: 1)
    
    // MARK: - Lifecycle Methods
    
    convenience init(frame: CGRect, buttonTitles: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitles
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        updateView()
    }
    
    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        updateView()
    }
    
    // MARK: - Methods
    
    private func updateView() {
        setButtons()
        setSelector()
        setStackView()
    }
    
    
    private func setButtons() {
        buttons.removeAll()
        subviews.forEach {$0.removeFromSuperview()}
        
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(normalColor, for: .normal)
            button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
            button.addTarget(self, action: #selector(onClicked(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectedColor, for: .normal)
    }
    
    private func setStackView() {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func setSelector() {
        selectorView = UIView(frame: CGRect(x: 0 + (tabWidth / 3 / 2), y: self.frame.height, width: tabWidth - (tabWidth / 3), height: 2))
        selectorView.backgroundColor = selectedColor
        addSubview(selectorView)
    }
    
    // MARK: - Actions
    
    @objc
    private func onClicked(_ sender: UIButton) {
        for (index, button) in buttons.enumerated() {
            button.setTitleColor(normalColor, for: .normal)
            
            if button == sender {
                button.setTitleColor(selectedColor, for: .normal)
                let x = tabWidth * CGFloat(index) + (tabWidth / 3 / 2)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = x
                }
            }
        }
    }
}
