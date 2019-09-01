//
//  GitHubNetworkManager_RequestRetrier.swift
//  BaseProject
//
//  Created by dongseok lee on 02/09/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Alamofire

extension GitHubNetworkManager {
    final class NetworkRequestRetrier: RequestRetrier {
        private let lock = NSLock()
        private var retriedRequests: [String: Int] = [:]
        private static let retryCount = 3
        
        func should(
            _ manager: SessionManager,
            retry request: Request,
            with error: Error,
            completion: @escaping RequestRetryCompletion
            ) {
            lock.lock() ; defer { lock.unlock() }
            
            guard let url = request.request?.url?.absoluteString else {
                completion(false, 0.0)
                return
            }
            guard isRetrieableStatus(response: request.task?.response) else {
                retriedRequests.removeValue(forKey: url)
                completion(false, 0.0)
                return
            }
            guard let retryCount = retriedRequests[url] else {
                retriedRequests[url] = 1
                completion(true, 1.0)
                return
            }
            guard retryCount >= NetworkRequestRetrier.retryCount else {
                retriedRequests[url] = retryCount + 1
                completion(true, 1.0)
                return
            }
            retriedRequests.removeValue(forKey: url)
            completion(false, 0.0)
        }
        private func isRetrieableStatus(response: URLResponse?) -> Bool {
            guard let code = (response as? HTTPURLResponse)?.statusCode else { return false }
            switch code {
            case 500, 503, 504: return true
            default: return false
            }
        }
    }
}
