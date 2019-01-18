//
//  DrinkService.swift
//  Services
//
//  Created by gonzaloz on 1/16/19.
//  Copyright © 2019 gonzaloz. All rights reserved.
//

import Foundation
import Alamofire
import ImmutableModels

// Service layer
public class DrinkService {
    
    static let serverURL = "http://www.thecocktaildb.com/api/json/v1/1/"

    // get full list
    public static func getDrinksList(success: @escaping (DrinksListResult) -> (), failure: @escaping (Error) -> ()) {
        let url = serverURL + "filter.php?g=Cocktail_glass"
        AF.request(url, method: .get).responseJSON() { response in
            switch response.result {
            case .success(let JSON):
                guard let resultDict = JSON as? NSDictionary else {
                    assertionFailure("This error will be shown only in debug, and it is fine because this should never happen. If it happens to be shown we are doing something wrong and we can correct it while testing")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: resultDict)
                    let searchResults = try decoder.decode(DrinksListResult.self, from: jsonData)
                    success(searchResults)
                } catch let error {
                    failure(error)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }

    // Get drink details by id
    public static func getDrinkDetails(drinkListItem: DrinkListItem, success: @escaping (DrinkItem) -> (), failure: @escaping (Error) -> ()) {
        let url = serverURL + "lookup.php?i=\(drinkListItem.idDrink)"
        AF.request(url, method: .get).responseJSON() { response in
            switch response.result {
            case .success(let JSON):
                guard let resultDict = JSON as? NSDictionary else {
                    assertionFailure("This error will be shown only in debug, and it is fine because this should never happen. If it happens to be shown we are doing something wrong and we can correct it while testing")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: resultDict)
                    let drinkResult = try decoder.decode(DrinkItemResult.self, from: jsonData)
                    if drinkResult.drinks.indices.contains(0) {
                        success(drinkResult.drinks[0])
                    } else {
                        failure(NSError(domain: "No item found", code: 1, userInfo: nil))
                    }
                } catch let error {
                    failure(error)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
}
