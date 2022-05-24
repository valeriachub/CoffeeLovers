//
//  SectionHeaderView.swift
//  CoffeeLovers
//
//  Created by Valeria Chub on 24.05.2022.
//  Copyright © 2022 Valeria. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = String(describing: self)
    
    private let label: UILabel
    
    override init(reuseIdentifier: String?) {
        label = UILabel()
        super.init(reuseIdentifier: reuseIdentifier)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        label.textColor = UIColor.init(named: "CoffeeLabel")
        label.font = UIFont.init(name: "Avenir-Heavy", size: 15)
    }
    
    func set(_ text: String) {
        label.text = text
    }
    
    required init?(coder: NSCoder) {
        label = UILabel()
        super.init(coder: coder)
    }
}
