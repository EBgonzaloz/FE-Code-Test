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
            titleLabel.textColor = UIColor.textColor
        }
    }
    @IBOutlet weak var detailLabel: UILabel! {
        didSet {
            detailLabel.textColor = UIColor.textColor
            detailLabel.numberOfLines = 0
            detailLabel.text = "API response is not returning the data shown in the wireframe for this cell, so this is a dummy label"
            detailLabel.sizeToFit()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.backgroundColor
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
