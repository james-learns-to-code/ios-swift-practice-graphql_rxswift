//
//  UIImageView+KingfisherExtension.swift
//  BaseProject
//
//  Created by leedongseok on 19/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageByKF(with urlString: String?) {
        kf.cancelDownloadTask()
        guard let string = urlString else { return }
        let url = URL(string: string)
        kf.setImage(with: url)
    }
}
