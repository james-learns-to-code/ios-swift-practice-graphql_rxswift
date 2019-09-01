//
//  GitHubNetworkManager.swift
//  BaseProject
//
//  Created by leedongseok on 17/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Alamofire

typealias API = GitHubNetworkManager

final class GitHubNetworkManager: NetworkManager {
    static let shared = GitHubNetworkManager()
    
    override init() {
        super.init()
        let adaptor = AccessTokenAdapter()
        let retrier = NetworkRequestRetrier()
        super.setAdapter(adaptor)
        super.setRetrier(retrier)
    }
    
    static let defaultNumOfItem = 20
}

extension GitHubNetworkManager {
    struct Handler<Type: GithubAPIResponseable> {
        static func handleResult(
            _ result: DataResult,
            handler: @escaping (Swift.Result<Type, GitHubNetworkError>) -> Void) {
            Decoder<Type>
                .decodeResult(result) { result in
                    switch result {
                    case .success(let value):
                        if let errors = value.errors {
                            handler(.failure(.githubApi(errors: errors)))
                            return
                        }
                        handler(.success(value))
                    case .failure(let error):
                        let err = GitHubNetworkError.convertError(error)
                        handler(.failure(err))
                    }
            }
        }
    }
}
