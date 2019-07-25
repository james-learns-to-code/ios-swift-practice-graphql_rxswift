//
//  GitHubNetworkManagerQueryReplacer.swift
//  BaseProject
//
//  Created by leedongseok on 19/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

extension GitHubNetworkManager {
    struct QueryReplacer {
        static let base = "&QUERY_REPLACE_"
        static let userName = base + "USER_NAME"
        static let numOfItem = base + "NUM_OF_ITEM"
        static let afterCursor = base + "CURSOR"
        static let variableCursor = """
, \
  "cursor": &QUERY_REPLACE_CURSOR
"""
        static let parameterCursor = ", $cursor: String!"
        static let parameterAfterCursor = ", after: $cursor"
    
        static func getQuerySearchUserByReplacing(name: String, cursor: String?) -> String {
            var body = querySearchUser
                .replacingOccurrences(of: userName, with: "\"\(name)\"")
                .replacingOccurrences(of: numOfItem, with: "\(GitHubNetworkManager.defaultNumOfItem)")
            
            if let cursor = cursor {
                body = body
                    .replacingOccurrences(of: afterCursor, with: "\"\(cursor)\"")
            } else {
                body = body
                    .replacingOccurrences(of: parameterCursor, with: "")
                    .replacingOccurrences(of: parameterAfterCursor, with: "")
                    .replacingOccurrences(of: variableCursor, with: "")
            }
            return body
        }
    }
}
