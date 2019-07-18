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
    
    static let url = URL(string: "https://api.github.com/graphql")

    static let githubHeader: [String: String] = [
        "Content-Type": "application/json",
        "Authorization": "token " + access_token
    ]
    
    static var access_token: String {
        if let filepath = Bundle.main.path(forResource: "GitHubAccessToken", ofType: "credential") {
            if let token = try? String(contentsOfFile: filepath, encoding: .utf8) {
                return token.filter { !$0.isNewline && !$0.isWhitespace }
            }
        }
        assertionFailure("You need to create 'GitHubAccessToken.credential' file contains token for accessing GitHub API")
        return ""
    }
}

// MARK: Interface
extension GitHubNetworkManager {
    func requestUserListByName(
        _ name: String,
        handler: @escaping (Result<GraphQLSearchResultResponseModel, Error>) -> Void) {
       
        let body =
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
  "user": "james", \
  "numOfItem": 2, \
  "cursor": "Y3Vyc29yOjIx" \
} \
}
"""

        request(
        with: GitHubNetworkManager.url,
        query: body,
        type: .post,
        header: GitHubNetworkManager.githubHeader) { result in
            ResultType<GraphQLSearchResultResponseModel>
                .handle(result, handler: handler)
        }
    }
}

class GraphQLResponseErrorModel: Codable {
    var message: String?
}

class GraphQLSearchResultResponseModel: Codable {
    var data: GraphQLSearchResultModel?
    var errors: GraphQLResponseErrorModel?
}

class GraphQLSearchResultModel: Codable {
    var search: GraphQLSearchNodesModel?
}

class GraphQLSearchNodesModel: Codable {
    var nodes: [GraphQLSearchNodeModel]?
    var pageInfo: GraphQLPageInfoModel?
}

class GraphQLSearchNodeModel: Codable {
    var __typename: String?
    var name: String?
    var login: String?
    var avatarUrl: String?
    var url: String?
    var bio: String?
    var repository: GraphQLRepositoryMetaModel?
}

class GraphQLRepositoryMetaModel: Codable {
    var totalCount: Int?
}

class GraphQLPageInfoModel: Codable {
    var endCursor: String?
    var hasNextPage: Bool?
}
