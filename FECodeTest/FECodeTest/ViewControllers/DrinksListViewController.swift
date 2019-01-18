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

// Delegate to let the coordinator know that the user is interacting with this VC
protocol DrinkListDelegate: class {
    func didSelectItem(item: DrinkListItem)
    func didSearchDrinks(text: String?)
}

class DrinksListViewController: UIViewController {

    var drinksList: [DrinkListItem]? = nil {
        didSet {
            errorLabel.isHidden = drinksList?.count ?? 0 > 0
            tableView.reloadData()
        }
    }

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "Random Drinks"
        }
    }

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = UIColor.backgroundColor
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

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.barTintColor = UIColor.backgroundColor
            searchBar.backgroundImage = Image()
            searchBar.layer.borderColor = UIColor.clear.cgColor
            searchBar.delegate = self
        }
    }

    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            errorLabel.textColor = UIColor.white
            errorLabel.isHidden = true
        }
    }

    weak var delegate: DrinkListDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        // Register cell
        tableView.register(UINib(nibName: DrinkTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: DrinkTableViewCell.cellIdentifier)
        self.navigationItem.title = "Random Drinks"
    }

}

// MARK: TableView Delegate
extension DrinksListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrinkTableViewCell.cellIdentifier, for: indexPath) as? DrinkTableViewCell, let drinksList = drinksList, drinksList.indices.contains(indexPath.row) else { return UITableViewCell() }
        // Get the item
        let item = drinksList[indexPath.row]

        // Configure cell
        cell.titleLabel.text = item.strDrink
        let imageURL = URL(string: item.strDrinkThumb)
        cell.drinkImageView.kf.setImage(with: imageURL)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let drinksList = drinksList, drinksList.indices.contains(indexPath.row) else { return }
        let item = drinksList[indexPath.row]

        // When a row is selected we just let the delegate know what happened, it will take care
        delegate?.didSelectItem(item: item)
    }
}

// MARK: SearchBar Delegate
extension DrinksListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didSearchDrinks(text: searchBar.text != nil && !searchBar.text!.isEmpty ? searchBar.text : nil)
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.isEmpty {
            searchBar.placeholder = "empty search for everything"
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = ""
    }

}
