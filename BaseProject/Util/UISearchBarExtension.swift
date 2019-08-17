//
//  UISearchBarExtension.swift
//  BaseProject
//
//  Created by leedongseok on 17/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

extension UISearchBar {
    func resignFirstResponderIfIsFirstResponder() {
        guard isFirstResponder else { return }
        resignFirstResponder()
    }
}
