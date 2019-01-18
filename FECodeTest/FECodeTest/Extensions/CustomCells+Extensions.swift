//
//  CustomCells+Extensions.swift
//  FECodeTest
//
//  Created by gonzaloz on 1/16/19.
//  Copyright © 2019 gonzaloz. All rights reserved.
//

import UIKit

protocol CellIdentifier {
    static var cellIdentifier: String { get }
}

extension CellIdentifier {
    static var cellIdentifier: String {
        get {
            let className = String(describing: self)
            if let last = className.components(separatedBy: ".").last {
                return last
            } else {
                return className
            }
            
        }
    }

}

extension UITableViewCell: CellIdentifier {}

extension UITableView {
    func register<T>(cell: T.Type) where T: CellIdentifier {
        register(UINib(nibName: cell.cellIdentifier, bundle: nil), forCellReuseIdentifier: cell.cellIdentifier)
    }
}
