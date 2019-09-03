//
//  MLControl.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 9/3/19.
//  Copyright © 2019 Valeria. All rights reserved.
//

import UIKit

protocol MLControlDelegate: class {
    func onMLTabClicked(index: Int)
}


class MLControl: UIView {

    // MARK: - Properties
    
    private var buttonTitles = [String]()
    private var _selectedIndex = 0
    private var buttons = [UIButton]()
    private var selectorView: UIView!
    private var tabWidth: CGFloat {
        return self.bounds.width / CGFloat(buttons.count)
    }
    
    var normalColor = #colorLiteral(red: 0.4431372549, green: 0.462745098, blue: 0.4784313725, alpha: 1)
    var selectedColor = #colorLiteral(red: 0.9725490196, green: 0.1450980392, blue: 0.2901960784, alpha: 1)
    var selectedTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var cornerRadius: CGFloat = 10.0
    var selectedIndex: Int {
        return _selectedIndex
    }
    weak var delegate: MLControlDelegate?
    
    // MARK: - Lifecycle Methods
    
    convenience init(frame: CGRect, buttonTitles: [String], delegate: MLControlDelegate) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitles
        self.delegate = delegate
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
        setBackground()
        setButtons()
        setSelector()
        setStackView()
    }
    
    private func setBackground() {
        self.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
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
        
        buttons[0].setTitleColor(selectedTextColor, for: .normal)
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
        selectorView = UIView(frame: CGRect(x: 0, y: 0, width: tabWidth, height: self.frame.height))
        selectorView.backgroundColor = selectedColor
        selectorView.layer.cornerRadius = cornerRadius
        addSubview(selectorView)
    }
    
    func setIndex(index: Int) {
        buttons.forEach { $0.setTitleColor(normalColor, for: .normal) }
        
        let button = buttons[index]
        _selectedIndex = index
        button.setTitleColor(selectedTextColor, for: .normal)
        
        let x = tabWidth * CGFloat(index)
        UIView.animate(withDuration: 0.3) {
            self.selectorView.frame.origin.x = x
        }
        
        delegate?.onMLTabClicked(index: index)
    }
    
    // MARK: - Actions
    
    @objc
    private func onClicked(_ sender: UIButton) {
        for (index, button) in buttons.enumerated() {
            button.setTitleColor(normalColor, for: .normal)
            
            if button == sender {
                let x = tabWidth * CGFloat(index)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = x
                }
                
                button.setTitleColor(selectedTextColor, for: .normal)
                _selectedIndex = index
                delegate?.onMLTabClicked(index: index)
            }
        }
    }
}
