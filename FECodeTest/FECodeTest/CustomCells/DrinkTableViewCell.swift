//
//  DrinkTableViewCell.swift
//  FECodeTest
//
//  Created by gonzaloz on 1/16/19.
//  Copyright © 2019 gonzaloz. All rights reserved.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var drinkImageView: UIImageView! {
        didSet {
            drinkImageView.layer.cornerRadius = 5
            drinkImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        }
    }
    @IBOutlet weak var detailLabel: UILabel! {
        didSet {
            detailLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            detailLabel.numberOfLines = 0
            detailLabel.text = "API response is not returning the data shown in the wireframe for this cell, so this is a dummy label"
            detailLabel.sizeToFit()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = #colorLiteral(red: 0.4235294118, green: 0.7294117647, blue: 0.8078431373, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
