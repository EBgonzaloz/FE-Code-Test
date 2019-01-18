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

    @IBOutlet weak var prepLabel: UILabel! {
        didSet {
            prepLabel.textColor = UIColor.prepColor
        }
    }

    @IBOutlet weak var instructionsTextView: UITextView! {
        didSet {
            instructionsTextView.textColor = UIColor.prepColor
        }
    }

    var item: DrinkItem! {
        didSet {
            // Configure the view controller
            if let imageURL = URL(string: item.strDrinkThumb) {
                imageView.kf.setImage(with: imageURL)
            }

            // Set up the preparation list
            let prepDetails = item.getPreparationDetails()
            var prepStrings = [""]
            // Because of the API response we are sure we will always get 15 of each (ingredients and measures)
            for i in 0...14 {
                // Ingredients could be nil or empty (because of API)
                if prepDetails.ingredients.indices.contains(i) && !prepDetails.ingredients[i].isEmpty {
                    prepStrings.append(getPreparationItem(ingredient: prepDetails.ingredients[i], measure: prepDetails.measures[i]))
                    let string = prepStrings.joined(separator: "\n")
                    prepLabel.text = string
                }
            }

            // Set up the TextView
            guard let instructions = item.strInstructions else { return }
            instructionsTextView.text = "How to prepare \n \n \(instructions)"

            // Set up navBar
            self.navigationItem.title = item.strDrink
        }
    }

    func getPreparationItem(ingredient: String, measure:String) -> String {
        let preparationItemString = "\(measure) - \(ingredient)"
        return preparationItemString.replacingOccurrences(of: "\n", with: "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.backgroundColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }


}
