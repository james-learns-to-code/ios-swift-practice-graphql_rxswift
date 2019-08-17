//
//  GitHubSearchResultResponseModel.swift
//  BaseProject
//
//  Created by leedongseok on 18/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

struct GitHubSearchResultResponseModel: Codable {
    let data: GitHubSearchResultModel?
    let errors: [GitHubResponseErrorModel]?
}

struct GitHubResponseErrorModel: Codable {
    let message: String?
}

struct GitHubSearchResultModel: Codable {
    let search: GitHubSearchNodesModel?
}

struct GitHubSearchNodesModel: Codable {
    let nodes: [GitHubSearchUserModel]?
    let pageInfo: GitHubPageInfoModel?
}

struct GitHubSearchUserModel: Codable {
    let login: String?
    let avatarUrl: String?
    let repositories: GitHubRepositoriesModel?
}

struct GitHubRepositoriesModel: Codable {
    let totalCount: Int?
}

struct GitHubPageInfoModel: Codable {
    let endCursor: String?
    let hasNextPage: Bool?
}
