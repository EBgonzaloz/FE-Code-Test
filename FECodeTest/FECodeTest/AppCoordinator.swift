//
//  AppCoordinator.swift
//  FECodeTest
//
//  Created by gonzaloz on 1/15/19.
//  Copyright © 2019 gonzaloz. All rights reserved.
//

import Foundation
import Services

//AppCoordinator will handle the app flow. It also takes out some responsibilities from UIViewControllers such as fetching data from server, handling data, etc.
public class AppCoordinator: NSObject {
    
    private var listViewController: DrinksListViewController?
//    private var detailsViewController = DrinkDetailViewController?
    private var navViewController: UINavigationController?

    func start(with appWindow: UIWindow) {
        listViewController = DrinksListViewController()
        // I can force the unwraping here since I just set the value in the above line
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

