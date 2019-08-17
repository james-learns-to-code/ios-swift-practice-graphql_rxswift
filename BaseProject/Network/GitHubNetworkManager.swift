//
//  GitHubNetworkManager.swift
//  BaseProject
//
//  Created by leedongseok on 17/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

final class GitHubNetworkManager: NetworkManager {
    static let shared = GitHubNetworkManager()
    
    static let url = URL(string: "https://api.github.com/graphql")!

    static let header: HeaderType = [
        "Content-Type": "application/json",
        "Authorization": authorization
    ]
    
    private static var authorization: String {
        return "token " + accessToken
    }
    
    private static var accessToken: String {
        guard let token = String
            .getPureStringFromBundle("GitHubAccessToken", ofType: "credential") else {
            assertionFailure("You need to create 'GitHubAccessToken.credential' file contains token for accessing GitHub API")
            return ""
        }
        return token
    }
    
    static let defaultNumOfItem = 20
}
