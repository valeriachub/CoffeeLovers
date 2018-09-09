//
//  CoffeeAdditionsView.swift
//  CoffeeLovers
//
//  Created by Valeria on 09.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit

protocol CoffeeAdditionsDelegate {
    func creamPressed(isCreamSelected : Bool)
    func syrupPressed(isSyrupSelected : Bool)
}

@IBDesignable
class CoffeeAdditionsView: UIStackView {
    
    var delegate : CoffeeAdditionsDelegate?
    var isCreamSelected : Bool = false
    var isSyrupSelected : Bool = false
    
    lazy var creamImage : UIImageView = {
        let cream = UIImageView()
        cream.image = UIImage(named: "cream_unselected")
        cream.translatesAutoresizingMaskIntoConstraints = false
        cream.isUserInteractionEnabled = true
        return cream
    }()
    
    lazy var syrupImage : UIImageView = {
        let syrup = UIImageView()
        syrup.image = UIImage(named: "syrup_unselected")
        syrup.translatesAutoresizingMaskIntoConstraints = false
        syrup.isUserInteractionEnabled = true
        return syrup
    }()
    
    lazy var emptyView1 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emptyView2 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView(){
        
        addArrangedSubview(creamImage)
        addArrangedSubview(syrupImage)
        addArrangedSubview(emptyView1)
        addArrangedSubview(emptyView2)
        
        creamImage.widthAnchor.constraint(equalTo: syrupImage.widthAnchor, multiplier: 1.0).isActive = true
        syrupImage.widthAnchor.constraint(equalTo: emptyView1.widthAnchor, multiplier: 1.0).isActive = true
        emptyView1.widthAnchor.constraint(equalTo: emptyView2.widthAnchor, multiplier: 1.0).isActive = true
        
        creamImage.contentMode = .center
        syrupImage.contentMode = .center
        
        setupActions()
    }
    
    private func setupActions(){
        let creamGesture = UITapGestureRecognizer(target: self, action: #selector(creamPressed))
        creamImage.addGestureRecognizer(creamGesture)
        
        let syrupGesture = UITapGestureRecognizer(target: self, action: #selector(syrupPressed))
        syrupImage.addGestureRecognizer(syrupGesture)
    }
    
    //MARK: - Actions
    
    @objc private func creamPressed(){
        print("cream pressed")
        isCreamSelected = !isCreamSelected
        creamImage.image = UIImage(named: isCreamSelected ? "cream_selected" : "cream_unselected")
        delegate?.creamPressed(isCreamSelected: isCreamSelected)
    }
    
    @objc private func syrupPressed(){
        print("syrup pressed")
        isSyrupSelected = !isSyrupSelected
        syrupImage.image = UIImage(named: isSyrupSelected ? "syrup_selected" : "syrup_unselected")
        delegate?.syrupPressed(isSyrupSelected: isSyrupSelected)
    }
    
    //custom views should override this to return true if
    //they cannot layout correctly using autoresizing.
    //from apple docs https://developer.apple.com/documentation/uikit/uiview/1622549-requiresconstraintbasedlayout
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
