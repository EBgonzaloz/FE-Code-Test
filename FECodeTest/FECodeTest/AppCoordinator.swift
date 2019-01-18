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

    var drinksList: [DrinkListItem]?

    func start(with appWindow: UIWindow) {
        listViewController = DrinksListViewController()
        listViewController?.delegate = self

        // I can force the unwraping here since I just set the value two lines above
        let navController = UINavigationController(rootViewController: self.listViewController!)
        navViewController = navController
        navViewController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navViewController?.navigationBar.shadowImage = UIImage()
        navViewController?.navigationBar.isTranslucent = true
        navViewController?.navigationBar.tintColor = .white

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navViewController?.navigationBar.titleTextAttributes = textAttributes

        appWindow.rootViewController = navController
        appWindow.makeKeyAndVisible()

        let spinnerView = displaySpinner()
        DrinkService.getDrinksList(success: { [self] (result) in
            spinnerView?.removeFromSuperview()
            self.drinksList = result.drinks
            self.listViewController?.drinksList = result.drinks
        }) { (error) in
            spinnerView?.removeFromSuperview()
            print(error)
        }
    }

    func displaySpinner() -> UIView? {
        guard let navViewController = navViewController, let onView = navViewController.topViewController?.view else { return nil }
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }

}

extension AppCoordinator: DrinkListDelegate {

    func didSelectItem(item: DrinkListItem) {
        let spinnerView = displaySpinner()
        DrinkService.getDrinkDetails(drinkListItem: item, success: {[self] result in
            spinnerView?.removeFromSuperview()
            let detailsViewController = DrinkDetailViewController()
            _ = detailsViewController.view
            detailsViewController.item = result

            self.navViewController?.pushViewController(detailsViewController, animated: true)
        }, failure: { error in
            spinnerView?.removeFromSuperview()
            print(error)
        })
    }

    func didSearchDrinks(text: String?) {
        guard let text = text else {
            listViewController?.drinksList = self.drinksList
            return
        }
        guard let drinksList = drinksList else { assertionFailure("This should never happen, if it happens we are doing something wrong"); return }
        let result = drinksList.filter { $0.strDrink.contains(text) }
        listViewController?.drinksList = result
    }
}

