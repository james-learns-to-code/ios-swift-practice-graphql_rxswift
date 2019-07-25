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
        dataTask?.cancel()
    }
    
    // MARK: Pagination
    
    private var pageInfo: GitHubPageInfoModel?
    
    // MARK: API
    private var dataTask: URLSessionDataTask?
    func searchGithubUserIfCan(by name: String?, isPagination: Bool = false) {
        if isPagination {
            guard let hasNextPage = pageInfo?.hasNextPage else { return }
            guard hasNextPage == true else { return }
        } else {
            pageInfo = nil
        }
        guard let name = name, name.count > 0 else {
            resetData()
            return
        }
        searchGithubUser(by: name, isPagination: isPagination)
    }
    
    private func searchGithubUser(by name: String, isPagination: Bool) {
        dataTask = GitHubNetworkManager.shared
            .requestUserListByName(name, cursor: pageInfo?.endCursor) {
                [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    self.pageInfo = value.data?.search?.pageInfo
                    guard var users = value.data?.search?.nodes else { return }
                    if isPagination {
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


