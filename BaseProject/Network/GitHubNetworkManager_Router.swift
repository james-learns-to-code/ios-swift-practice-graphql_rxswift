//
//  GitHubNetworkManager_Router.swift
//  BaseProject
//
//  Created by dongseok lee on 02/09/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Alamofire

extension GitHubNetworkManager {
    enum Router: URLRequestConvertible {
        case search(name: String, cursor: String?)
        
        func asURLRequest() throws -> URLRequest {
            switch self {
            case .search(let name, let cursor):
                
                let body = QueryReplacer.getSearchUserQueryByReplacing(
                    GitHubNetworkManager.searchUserQuery,
                    name: name,
                    cursor: cursor)
                
                var req = URLRequest(url: Router.url)
                req.httpMethod = HTTPMethod.post.rawValue
                req.httpBody = body.data(using: .utf8)

                return req
            }
        }
        
        static let url = URL(string: "https://api.github.com/graphql")!
    }
}
