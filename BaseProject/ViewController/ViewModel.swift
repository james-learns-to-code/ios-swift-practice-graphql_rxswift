//
//  ViewModel.swift
//  BaseProject
//
//  Created by leedongseok on 18/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ViewModel {
    
    let users: BehaviorRelay<[GitHubSearchUserModel]> = BehaviorRelay(value: [])
    let searchText: BehaviorRelay<String> = BehaviorRelay(value: "")

    // MARK: Interface

    func resetData() {
        users.accept([])
        pageInfo = nil
    }
    
    func cancelRequest() {
        guard dataTask?.state != .completed else { return }
        dataTask?.cancel()
    }
    
    // MARK: Pagination
    
    private var pageInfo: GitHubPageInfoModel?
    private var hasNextPage: Bool {
        return pageInfo?.hasNextPage ?? false
    }
    private var endCursor: String? {
        return pageInfo?.endCursor
    }
    
    // MARK: API
    private var dataTask: URLSessionDataTask?
    func searchGithubUserIfCan(by name: String?, pagination: Bool = false) {
        if pagination {
            guard hasNextPage == true else { return }
        }
        guard let name = name, name.count > 0 else {
            resetData()
            return
        }
        searchGithubUser(by: name, pagination: pagination)
    }
    
    private func searchGithubUser(by name: String, pagination: Bool) {
        dataTask = GitHubNetworkManager.shared
            .requestUserListByName(name, cursor: endCursor) {
                [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    self.pageInfo = value.data?.search?.pageInfo
                    guard var users = value.data?.search?.nodes else { return }
                    if pagination {
                        users = self.users.value + users
                    }
                    self.users.accept(users)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    static let title = "Github Repos"
    static let bottomInset = 100
}
