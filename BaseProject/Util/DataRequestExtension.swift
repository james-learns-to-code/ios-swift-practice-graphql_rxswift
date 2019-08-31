//
//  URLSessionDataTaskExtension.swift
//  BaseProject
//
//  Created by James Lee on 19/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Alamofire

extension DataRequest {
    func cancelIfNotCompleted() {
        guard let state = task?.state, state != .completed else { return }
        cancel()
    }
}
