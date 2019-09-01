//
//  GitHubNetworkManager_RequestAdapter.swift
//  BaseProject
//
//  Created by dongseok lee on 01/09/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Alamofire

extension GitHubNetworkManager {
    final class AccessTokenAdapter: RequestAdapter {
        private static var accessToken: String {
            guard let token = String
                .getPureStringFromBundle("GitHubAccessToken", ofType: "credential") else {
                    assertionFailure(
                        "You need to create 'GitHubAccessToken.credential' file contains token for accessing GitHub API")
                    return ""
            }
            return token
        }
        
        func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
            var urlRequest = urlRequest
            urlRequest.setValue("token " + AccessTokenAdapter.accessToken, forHTTPHeaderField: "Authorization")
            return urlRequest
        }
    }
}
