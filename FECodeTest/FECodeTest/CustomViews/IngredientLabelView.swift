//
//  IngredientView.swift
//  FECodeTest
//
//  Created by gonzaloz on 1/16/19.
//  Copyright © 2019 gonzaloz. All rights reserved.
//

import UIKit

class IngredientLabelView: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with ingredient: String, and measure: String) {
        textColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
        self.text = "\(measure) - \(ingredient)"
    }

}
