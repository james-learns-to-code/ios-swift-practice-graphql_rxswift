//
//  GitHubSearchResultResponseModel.swift
//  BaseProject
//
//  Created by leedongseok on 18/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

struct GitHubSearchResultResponseModel: Codable {
    var data: GitHubSearchResultModel?
    var errors: GitHubResponseErrorModel?
}

struct GitHubResponseErrorModel: Codable {
    var message: String?
}

struct GitHubSearchResultModel: Codable {
    var search: GitHubSearchNodesModel?
}

struct GitHubSearchNodesModel: Codable {
    var nodes: [GitHubSearchNodeModel]?
    var pageInfo: GitHubPageInfoModel?
}

struct GitHubSearchNodeModel: Codable {
    var __typename: String?
    var name: String?
    var login: String?
    var avatarUrl: String?
    var url: String?
    var bio: String?
    var repository: GitHubRepositoryMetaModel?
}

struct GitHubRepositoryMetaModel: Codable {
    var totalCount: Int?
}

struct GitHubPageInfoModel: Codable {
    var endCursor: String?
    var hasNextPage: Bool?
}
