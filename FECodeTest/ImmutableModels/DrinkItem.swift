//
//  DrinkItem.swift
//  ImmutableModels
//
//  Created by gonzaloz on 1/16/19.
//  Copyright © 2019 gonzaloz. All rights reserved.
//

import Foundation

public struct DrinkItemResult: Decodable {
    public let drinks: [DrinkItem]
}

public struct DrinkItem: Decodable {
    public let idDrink: String
    public let strDrink: String
    public let strCategory: String?
    public let strAlcoholic: String?
    public let strGlass: String?
    public let strInstructions: String?
    public let strDrinkThumb: String
    public let strIngredient1: String?
    public let strIngredient2: String?
    public let strIngredient3: String?
    public let strIngredient4: String?
    public let strIngredient5: String?
    public let strIngredient6: String?
    public let strIngredient7: String?
    public let strIngredient8: String?
    public let strIngredient9: String?
    public let strIngredient10: String?
    public let strIngredient11: String?
    public let strIngredient12: String?
    public let strIngredient13: String?
    public let strIngredient14: String?
    public let strIngredient15: String?
    public let strMeasure1: String?
    public let strMeasure2: String?
    public let strMeasure3: String?
    public let strMeasure4: String?
    public let strMeasure5: String?
    public let strMeasure6: String?
    public let strMeasure7: String?
    public let strMeasure8: String?
    public let strMeasure9: String?
    public let strMeasure10: String?
    public let strMeasure11: String?
    public let strMeasure12: String?
    public let strMeasure13: String?
    public let strMeasure14: String?
    public let strMeasure15: String?

    public func getIngredients() -> (ingredients: [String], measures: [String]) {
        var ingredients: [String] = []
        var measures: [String] = []
        let mirroredObject = Mirror.init(reflecting: self)
        for (_, attribute) in mirroredObject.children.enumerated() {
            if let strValue = attribute.value as? String,  attribute.label?.contains("Ingredient") ?? false {
                ingredients.append(strValue)
            } else if let strValue = attribute.value as? String, attribute.label?.contains("Measure") ?? false {
                measures.append(strValue)
            }
        }
        return (ingredients, measures)
    }

}
