//
//  RootViewController.swift
//  BaseProject
//
//  Created by leedongseok on 26/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    func presentVC() {
        let vc = ViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: false, completion: nil)
    }
}
