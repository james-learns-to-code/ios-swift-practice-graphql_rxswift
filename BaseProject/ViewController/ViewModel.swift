//
//  ViewModel.swift
//  BaseProject
//
//  Created by leedongseok on 18/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

final class ViewModel {
    
    var users = Binding<[GitHubSearchUserModel]>(value: [GitHubSearchUserModel]())
    
    func user(at indexPath: IndexPath) -> GitHubSearchUserModel? {
        return users.value?[safe: indexPath.row]
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return users.value?.count ?? 0
    }
     
    // MARK: API
    func fetchUserList() {
        let name = "james"
        GitHubNetworkManager.shared.requestUserListByName(name) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                guard let users = value.data?.search?.nodes else { return }
                self.users.value?.append(contentsOf: users)
            case .failure(let error):
                print(error)
            }
        }
    }
}

