//
//  IngredientsView.swift
//  CoffeeLovers
//
//  Created by Valeria on 01.09.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import CoreData

class IngredientsView : UIStackView {
    var coffee : Coffee? {
        didSet{
//            setup()
        }
    }
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    private var ingrediensArray = [IngredientOfCoffee]()
    
    //MARK: - Initializing
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - View Setup Methods
    
//    private func setup(){
//        
//        let coffeeTitle = coffee!.title
//        
//        let request : NSFetchRequest<IngredientOfCoffee> = IngredientOfCoffee.fetchRequest()
//        let predicate = NSPredicate(format: "coffee.title == %@", coffeeTitle!)
//        request.predicate = predicate
//        request.sortDescriptors = [NSSortDescriptor(key: "ingredient.title", ascending: true)]
//        
//        do{
//            ingrediensArray = try context.fetch(request)
//        }catch{
//            fatalError("Error getting ingrediens array")
//        }
//        
//        for (index, ingredient) in ingrediensArray.enumerated(){
//            let view = UIView()
//            
//            switch (ingredient.ingredient?.title) {
//                
//            case IngredientEnum.Espresso.rawValue :
//                temp(view : view, bgColor : UIColor.espressoColor(), title : IngredientEnum.Espresso.rawValue, isTitleColorLight : true, percentage : CGFloat(ingredient.percentage))
//                
//            case IngredientEnum.Water.rawValue :
//                temp(view : view, bgColor : UIColor.waterIceColor(), title : IngredientEnum.Water.rawValue, isTitleColorLight : false, percentage : CGFloat(ingredient.percentage))
//                
//            case IngredientEnum.Milk.rawValue :
//                temp(view : view, bgColor : UIColor.milkColor(), title : IngredientEnum.Milk.rawValue, isTitleColorLight : false, percentage : CGFloat(ingredient.percentage))
//                
//            case IngredientEnum.MilkFoam.rawValue :
//                temp(view : view, bgColor : UIColor.milkfoamColor(), title : IngredientEnum.MilkFoam.rawValue, isTitleColorLight : false, percentage : CGFloat(ingredient.percentage))
//                
//            case IngredientEnum.Chocolate.rawValue :
//                temp(view : view, bgColor : UIColor.chocolateColor(), title : IngredientEnum.Chocolate.rawValue, isTitleColorLight : true, percentage : CGFloat(ingredient.percentage))
//                
//            case IngredientEnum.Liquor.rawValue :
//                temp(view : view, bgColor : UIColor.liquorColor(), title : IngredientEnum.Liquor.rawValue, isTitleColorLight : true, percentage : CGFloat(ingredient.percentage))
//                
//            case IngredientEnum.IceCream.rawValue :
//                temp(view : view, bgColor : UIColor.icecreamColor(), title : IngredientEnum.IceCream.rawValue, isTitleColorLight : false, percentage : CGFloat(ingredient.percentage))
//                
//            case IngredientEnum.Ice.rawValue :
//                temp(view : view, bgColor : UIColor.waterIceColor(), title : IngredientEnum.Ice.rawValue, isTitleColorLight : false, percentage : CGFloat(ingredient.percentage))
//                
//            case IngredientEnum.Syrup.rawValue :
//                temp(view : view, bgColor : UIColor.liquorColor(), title : IngredientEnum.Syrup.rawValue, isTitleColorLight : true, percentage : CGFloat(ingredient.percentage))
//                
//            case IngredientEnum.Whiskey.rawValue :
//                temp(view : view, bgColor : UIColor.whiskeyColor(), title : IngredientEnum.Whiskey.rawValue, isTitleColorLight : true, percentage : CGFloat(ingredient.percentage))
//                
//            case IngredientEnum.WhippedCream.rawValue :
//                temp(view : view, bgColor : UIColor.icecreamColor(), title : IngredientEnum.WhippedCream.rawValue, isTitleColorLight : false, percentage : CGFloat(ingredient.percentage))
//                
//            case IngredientEnum.Caramel.rawValue :
//                temp(view : view, bgColor : UIColor.liquorColor(), title : IngredientEnum.Caramel.rawValue, isTitleColorLight : true, percentage : CGFloat(ingredient.percentage))
//                
//            case .none:
//                print("None")
//            case .some(_):
//                print("Some")
//            }
//            if index == ingrediensArray.count - 1 {
//                view.layer.cornerRadius = 4
//                view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
//            }
//            addArrangedSubview(view)
//        }
//    }
//    
//    private func temp(view : UIView, bgColor : UIColor, title : String, isTitleColorLight : Bool, percentage : CGFloat) {
//        view.translatesAutoresizingMaskIntoConstraints = false
////        view.heightAnchor.constraint(equalToConstant: self.frame.height/2).isActive = true
//        view.widthAnchor.constraint(equalToConstant: self.frame.width/5*CGFloat(percentage)).isActive = true
//        view.backgroundColor = bgColor
//        
//         let label = UILabel(frame: CGRect(x: 4, y: view.frame.height/2, width: self.frame.width/5*CGFloat(percentage), height: self.frame.height))
//      
//        label.text = title
//        label.font = label.font.withSize(10)
//        
//        if isTitleColorLight {
//            label.textColor = UIColor.white
//        }else {
//            label.textColor = UIColor.black
//        }
//        
//        view.addSubview(label)
//    }
//    
}
