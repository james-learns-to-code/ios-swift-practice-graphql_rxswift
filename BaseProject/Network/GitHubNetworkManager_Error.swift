//
//  GitHubNetworkManager_Error.swift
//  BaseProject
//
//  Created by dongseok lee on 02/09/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

enum GitHubNetworkError: Error {
    case undefined
    case url
    case response(error: Error?)
    case jsonDecoding(error: Error?)
    case query
    case githubApi(errors: [GitHubResponseErrorModel]?)
    
    static let domain = "app.network.github"
    
    var localizedDescription: String {
        switch self {
        case .response(let error):
            return error?.localizedDescription ?? self.localizedDescription
        case .jsonDecoding(let error):
            return error?.localizedDescription ?? self.localizedDescription
        case .githubApi(let errors):
            return errors?.first?.message ?? self.localizedDescription
        default:
            return self.localizedDescription
        }
    }
 
    static func convertError(_ error: NetworkError) -> GitHubNetworkError {
        switch error {
        case .undefined: return.undefined
        case .url: return .url
        case .response(let error): return .response(error: error)
        case .jsonDecoding(let error): return .jsonDecoding(error: error)
        }
    }
}
