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
    func setKFImage(with urlString: String?, placeholder: UIImage? = nil, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        kf.cancelDownloadTask()
        guard let string = urlString else { return }
        let url = URL(string: string)
        kf.setImage(with: url, placeholder: placeholder, completionHandler: completionHandler)
    }
}
