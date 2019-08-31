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
        private static let base = "&QUERY_REPLACE_"
        private static let userName = base + "USER_NAME"
        private static let numOfItem = base + "NUM_OF_ITEM"
        private static let afterCursor = base + "CURSOR"
        private static let variableCursor = """
, \
  "cursor": &QUERY_REPLACE_CURSOR
"""
        private static let parameterCursor = ", $cursor: String!"
        private static let parameterAfterCursor = ", after: $cursor"
    }
}

extension GitHubNetworkManager.QueryReplacer {
    static func getSearchUserQueryByReplacing(_ query: String, name: String, cursor: String?) -> String {
        let body = query
            .replacingOccurrences(of: userName, with: "\"\(name)\"")
            .replacingOccurrences(of: numOfItem, with: "\(GitHubNetworkManager.defaultNumOfItem)")
        
        if let cursor = cursor {
            return body
                .replacingOccurrences(of: afterCursor, with: "\"\(cursor)\"")
        } else {
            return body
                .replacingOccurrences(of: parameterCursor, with: "")
                .replacingOccurrences(of: parameterAfterCursor, with: "")
                .replacingOccurrences(of: variableCursor, with: "")
        }
    }
}
