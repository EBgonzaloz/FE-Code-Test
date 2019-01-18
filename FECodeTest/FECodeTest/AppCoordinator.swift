//
//  AppCoordinator.swift
//  FECodeTest
//
//  Created by gonzaloz on 1/15/19.
//  Copyright © 2019 gonzaloz. All rights reserved.
//

import Foundation
import Services
import ImmutableModels

//AppCoordinator will handle the app flow. It also takes out some responsibilities from UIViewControllers such as fetching data from server, handling data, etc.
public class AppCoordinator: NSObject {
    
    private var listViewController: DrinksListViewController?
    private var navViewController: UINavigationController?

    func start(with appWindow: UIWindow) {
        listViewController = DrinksListViewController()
        listViewController?.delegate = self
        // I can force the unwraping here since I just set the value two lines above
        let navController = UINavigationController(rootViewController: self.listViewController!)
        navViewController = navController
        appWindow.rootViewController = navController
        appWindow.makeKeyAndVisible()
        DrinkService.getDrinksList(success: { [listViewController] (result) in
            listViewController?.drinksList = result.drinks
        }) { (error) in
            print(error)
        }
    }
    
}

extension AppCoordinator: DrinkListDelegate {

    func didSelectItem(item: DrinkListItem) {
        DrinkService.getDrinkDetails(drinkListItem: item, success: {[self] result in
            let detailsViewController = DrinkDetailViewController()
            _ = detailsViewController.view
            detailsViewController.item = result

            self.navViewController?.pushViewController(detailsViewController, animated: true)
        }, failure: { error in
            print(error)
        })
    }
}

