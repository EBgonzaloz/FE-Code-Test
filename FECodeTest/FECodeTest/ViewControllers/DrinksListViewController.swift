//
//  DrinksListViewController.swift
//  FECodeTest
//
//  Created by gonzaloz on 1/15/19.
//  Copyright © 2019 gonzaloz. All rights reserved.
//

import UIKit
import ImmutableModels
import Kingfisher

protocol DrinkListDelegate {
    func didSelectItem(item: DrinkListItem)
}

class DrinksListViewController: UIViewController {

    var drinksList: [DrinkListItem]? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = #colorLiteral(red: 0.4235294118, green: 0.7294117647, blue: 0.8078431373, alpha: 1)
        }
    }

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "Random Drinks"
        }
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = UIColor.clear
            tableView.separatorStyle = .none
        }
    }

    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: DrinkTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: DrinkTableViewCell.cellIdentifier)
    }

}

extension DrinksListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrinkTableViewCell.cellIdentifier, for: indexPath) as? DrinkTableViewCell, let drinksList = drinksList, drinksList.indices.contains(indexPath.row) else { return UITableViewCell() }
        let item = drinksList[indexPath.row]
        cell.titleLabel.text = item.strDrink
        let imageURL = URL(string: item.strDrinkThumb)
        cell.drinkImageView.kf.setImage(with: imageURL)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

}
