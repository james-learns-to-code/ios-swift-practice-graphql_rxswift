//
//  GitHubNetworkManager_SearchUser.swift
//  BaseProject
//
//  Created by leedongseok on 19/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

extension GitHubNetworkManager {
    func requestUserListByName(
        _ name: String,
        cursor: String? = nil,
        handler: @escaping (Result<GitHubSearchResultResponseModel, NetworkError>) -> Void) -> URLSessionDataTask {
        
        let body = QueryReplacer.getReplacedForQuerySearchUser(name: name, cursor: cursor)

        return request(
            with: GitHubNetworkManager.url,
            type: .post,
            header: GitHubNetworkManager.header,
            body: body) { result in
                ResultType<GitHubSearchResultResponseModel>
                    .handleResult(result) { result in
                        switch result {
                        case .success(let value):
                            if let errors = value.errors {
                                handler(.failure(.githubApi(errors: errors)))
                                return
                            }
                            handler(.success(value))
                        case .failure(let error):
                            handler(.failure(error))
                        }
                }
        }
    }
    
    // MARK: GraphQL Query
    static let querySearchUser =
    """
{ \
   "query": \
"query SearchUsers($user: String!, $numOfItem: Int!, $cursor: String!) { \
  search(query: $user, type: USER, first: $numOfItem, after: $cursor) { \
    nodes { \
      __typename \
      ... on User { \
        name \
        login \
        avatarUrl \
        url \
        bio \
        repositories { \
          totalCount \
        } \
      } \
    } \
    pageInfo { \
      endCursor \
      hasNextPage \
    } \
  } \
}", \
    "variables": \
{ \
  "user": &QUERY_REPLACE_USER_NAME, \
  "numOfItem": &QUERY_REPLACE_NUM_OF_ITEM, \
  "cursor": &QUERY_REPLACE_CURSOR \
} \
}
"""
}
