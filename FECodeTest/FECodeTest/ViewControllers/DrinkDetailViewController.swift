//
//  DrinkDetailViewController.swift
//  FECodeTest
//
//  Created by gonzaloz on 1/16/19.
//  Copyright © 2019 gonzaloz. All rights reserved.
//

import UIKit
import ImmutableModels
import Kingfisher

class DrinkDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.layer.cornerRadius = 5
            scrollView.backgroundColor = UIColor.white
        }
    }
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 5
            imageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var ingredientsStackView: UIStackView!
    @IBOutlet weak var instructionsTextView: UITextView!

    var item: DrinkItem! {
        didSet {
            // Configure the view controller
            if let imageURL = URL(string: item.strDrinkThumb) {
                imageView.kf.setImage(with: imageURL)
            }

            // Set up the StackView
            let ingredients = item.getIngredients()
            for i in 0...14 {
                if ingredients.ingredients.indices.contains(i) && !ingredients.ingredients[i].isEmpty {
                    let view = IngredientLabelView(frame: CGRect(x: 0, y: 0, width: ingredientsStackView.frame.width, height: 20))
                    view.configure(with: ingredients.ingredients[i], and: ingredients.measures[i])
                    ingredientsStackView.addArrangedSubview(view)
//                    view.sizeToFit()
//                    view.layoutIfNeeded()
                }
            }
            ingredientsStackView.layoutIfNeeded()
            // Set up the TextView
            guard let instructions = item.strInstructions else { return }
            instructionsTextView.text = "How to prepare \n \n \(instructions)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
