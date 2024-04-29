//
//  UITableViewCell+Extension.swift
//  dacadoo technical exercise
//
//  Created by Santamarian Bogdan on 29.04.2024.
//

import UIKit

extension UITableViewCell {
    
    class func cellReuseIdentifier() -> String {
        return "\(self)"
    }
    
    class func registerByClassName(tableView: UITableView) {
        let cellIdentifier = cellReuseIdentifier()
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
}
