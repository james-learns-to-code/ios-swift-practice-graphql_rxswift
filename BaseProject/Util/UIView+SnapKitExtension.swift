//
//  UIView+SnapKitExtension.swift
//  BaseProject
//
//  Created by leedongseok on 26/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    func addSubview(_ view: UIView, constraint: (_ make: ConstraintMaker) -> Void) {
        addSubview(view)
        view.snp.makeConstraints(constraint)
    }
}
