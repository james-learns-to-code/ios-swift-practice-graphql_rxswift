//
//  UIAlertControllerExtension.swift
//  BaseProject
//
//  Created by leedongseok on 18/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

extension UIAlertController {
    convenience init(
        title: String,
        message: String?,
        doneButtonTitle: String,
        completed: ((UIAlertAction)-> Void)? = nil
        ) {
        self.init(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: doneButtonTitle,
            style: .default,
            handler: completed
        )
        addAction(action)
    }
}

