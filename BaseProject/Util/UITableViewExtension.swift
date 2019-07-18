//
//  UITableViewExtension.swift
//  BaseProject
//
//  Created by leedongseok on 18/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

extension UITableView { 
    func isLastRow(with indexPath: IndexPath) -> Bool {
        let num = numberOfRows(inSection: indexPath.section)
        if num == 0 { return false }
        return ((num - 1) == indexPath.row) ? true : false
    }
}
