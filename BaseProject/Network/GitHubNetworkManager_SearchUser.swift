//
//  GitHubNetworkManager_SearchUser.swift
//  BaseProject
//
//  Created by leedongseok on 19/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Alamofire
 
extension GitHubNetworkManager { 
    typealias SearchResultResultHandler = (Swift.Result<GitHubSearchResultResponseModel, GitHubNetworkError>) -> Void
    func requestUserListByName(
        _ name: String,
        cursor: String? = nil,
        handler: @escaping SearchResultResultHandler) -> DataRequest {
        return request(Router.search(name: name, cursor: cursor)) { result in
                Handler<GitHubSearchResultResponseModel>
                    .handleResult(result) { result in
                        switch result {
                        case .success(let value): 
                            handler(.success(value))
                        case .failure(let error):
                            handler(.failure(error))
                        }
                }
        }
    }
    
    // MARK: GraphQL Query
    static let searchUserQuery =
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

