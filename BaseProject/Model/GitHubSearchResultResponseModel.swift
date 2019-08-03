//
//  GitHubSearchResultResponseModel.swift
//  BaseProject
//
//  Created by leedongseok on 18/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

struct GitHubSearchResultResponseModel: Codable {
    private(set) var data: GitHubSearchResultModel?
    private(set) var errors: [GitHubResponseErrorModel]?
}

struct GitHubResponseErrorModel: Codable {
    private(set) var message: String?
}

struct GitHubSearchResultModel: Codable {
    private(set) var search: GitHubSearchNodesModel?
}

struct GitHubSearchNodesModel: Codable {
    private(set) var nodes: [GitHubSearchUserModel]?
    private(set) var pageInfo: GitHubPageInfoModel?
}

struct GitHubSearchUserModel: Codable {
    private(set) var login: String?
    private(set) var avatarUrl: String?
    private(set) var repositories: GitHubRepositoriesModel?
}

struct GitHubRepositoriesModel: Codable {
    private(set) var totalCount: Int?
}

struct GitHubPageInfoModel: Codable {
    private(set) var endCursor: String?
    private(set) var hasNextPage: Bool?
}
