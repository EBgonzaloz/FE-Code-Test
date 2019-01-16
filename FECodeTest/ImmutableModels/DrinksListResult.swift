//
//  DrinksListResult.swift
//  ImmutableModels
//
//  Created by gonzaloz on 1/16/19.
//  Copyright © 2019 gonzaloz. All rights reserved.
//

import Foundation

public struct DrinksListResult: Decodable {
    public let drinks: [DrinkListItem]
}
