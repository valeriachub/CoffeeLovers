//
//  Coffee+CoreDataClass.swift
//  
//
//  Created by Valeria Chub on 9/12/19.
//
//

import Foundation
import CoreData

@objc(ManagedCoffee)
public class ManagedCoffee: NSManagedObject {
    @NSManaged public var title: String
    @NSManaged public var image: String
    @NSManaged public var descriptions: String
    @NSManaged public var is_favourite: Bool
    @NSManaged public var ingredients: NSOrderedSet
    @NSManaged public var recipe: NSOrderedSet
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCoffee> {
        return NSFetchRequest<ManagedCoffee>(entityName: "CachedCoffee")
    }
    
    var localCoffee: Coffee {
        let ingredientsArray: [String] = (ingredients.array as! [StringHolder]).map { $0.value }
        let recipeArray: [String] = (recipe.array as! [StringHolder]).map { $0.value }
        
        return Coffee(title: title, image: image, isFavourite: is_favourite, descriptions: descriptions, ingredients: ingredientsArray, recipeSteps: recipeArray)
    }
    
    func addToIngredients(_ values: NSOrderedSet, context: NSManagedObjectContext) {
        for value in values {
            guard let stringValue = value as? String else { return }
            let ingredient = StringHolder(context: context)
            ingredient.value = stringValue
            
        }
    }
}

// MARK: Generated accessors for ingredients
extension ManagedCoffee {

    @objc(insertObject:inIngredientsAtIndex:)
    @NSManaged public func insertIntoIngredients(_ value: StringHolder, at idx: Int)

    @objc(removeObjectFromIngredientsAtIndex:)
    @NSManaged public func removeFromIngredients(at idx: Int)

    @objc(insertIngredients:atIndexes:)
    @NSManaged public func insertIntoIngredients(_ values: [StringHolder], at indexes: NSIndexSet)

    @objc(removeIngredientsAtIndexes:)
    @NSManaged public func removeFromIngredients(at indexes: NSIndexSet)

    @objc(replaceObjectInIngredientsAtIndex:withObject:)
    @NSManaged public func replaceIngredients(at idx: Int, with value: StringHolder)

    @objc(replaceIngredientsAtIndexes:withIngredients:)
    @NSManaged public func replaceIngredients(at indexes: NSIndexSet, with values: [StringHolder])

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: StringHolder)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: StringHolder)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSOrderedSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSOrderedSet)

}

// MARK: Generated accessors for recipe
extension ManagedCoffee {

    @objc(insertObject:inRecipeAtIndex:)
    @NSManaged public func insertIntoRecipe(_ value: StringHolder, at idx: Int)

    @objc(removeObjectFromRecipeAtIndex:)
    @NSManaged public func removeFromRecipe(at idx: Int)

    @objc(insertRecipe:atIndexes:)
    @NSManaged public func insertIntoRecipe(_ values: [StringHolder], at indexes: NSIndexSet)

    @objc(removeRecipeAtIndexes:)
    @NSManaged public func removeFromRecipe(at indexes: NSIndexSet)

    @objc(replaceObjectInRecipeAtIndex:withObject:)
    @NSManaged public func replaceRecipe(at idx: Int, with value: StringHolder)

    @objc(replaceRecipeAtIndexes:withRecipe:)
    @NSManaged public func replaceRecipe(at indexes: NSIndexSet, with values: [StringHolder])

    @objc(addRecipeObject:)
    @NSManaged public func addToRecipe(_ value: StringHolder)

    @objc(removeRecipeObject:)
    @NSManaged public func removeFromRecipe(_ value: StringHolder)

    @objc(addRecipe:)
    @NSManaged public func addToRecipe(_ values: NSOrderedSet)

    @objc(removeRecipe:)
    @NSManaged public func removeFromRecipe(_ values: NSOrderedSet)

}
