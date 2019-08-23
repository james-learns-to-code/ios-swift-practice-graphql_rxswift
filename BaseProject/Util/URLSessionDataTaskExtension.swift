//
//  URLSessionDataTaskExtension.swift
//  BaseProject
//
//  Created by James Lee on 19/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

extension URLSessionDataTask {
    func cancelIfNotCompleted() {
        guard state != .completed else { return }
        cancel()
    }
}
