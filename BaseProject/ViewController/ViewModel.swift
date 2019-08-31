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
import Alamofire

final class ViewModel {
    
    let users: BehaviorRelay<[GitHubSearchUserModel]> = .init(value: [])
    let error = PublishRelay<NetworkError>()
    let searchText = PublishRelay<String>()

    // MARK: Interface
    
    func searchGithubUserIfCan(by name: String?) {
        dataTask?.cancelIfNotCompleted()
        searchGithubUserIfCan(by: name, pagination: false)
    }
    func searchMoreGithubUserIfCan(by name: String?) {
        guard hasNextPage else { return }
        searchGithubUserIfCan(by: name, pagination: true)
    }
    
    func getAvataUrl(at indexPath: IndexPath) -> URL? {
        guard let urlStr = users.value[safe: indexPath.row]?.avatarUrl else { return nil }
        return URL(string: urlStr)
    }
    
    // MARK: Pagination
    
    private var pageInfo: GitHubPageInfoModel?
    private var hasNextPage: Bool {
        return pageInfo?.hasNextPage ?? false
    }
    private var endCursor: String? {
        return pageInfo?.endCursor
    }
    
    // MARK: Data
    
    private func resetData() {
        users.accept([])
        pageInfo = nil
    }
    
    // MARK: API
    private var dataTask: DataRequest?
    private func searchGithubUserIfCan(by name: String?, pagination: Bool) {
        guard let name = name, name.count > 0 else {
            resetData()
            return
        }
        searchGithubUser(by: name, pagination: pagination)
    }
    private func searchGithubUser(by name: String, pagination: Bool) {
        dataTask = API.shared
            .requestUserListByName(name, cursor: endCursor
            ) { [weak self] result in
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
                    self.error.accept(error)
                }
        }
    }
    
    // MARK: UI
    static let title = "Github Repos"
    static let bottomInset = 100
    static let searchBarDebounceMSec = 500
}
