//
//  URLRequestExtension.swift
//  BaseProject
//
//  Created by leedongseok on 18/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

extension URLRequest {
    mutating func setHttpBodyIfExist(_ body: String?) {
        guard let body = body else { return }
        httpBody = body.data(using: .utf8)
    }
}
