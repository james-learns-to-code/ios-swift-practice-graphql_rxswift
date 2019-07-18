//
//  StringExtension.swift
//  BaseProject
//
//  Created by leedongseok on 19/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

extension String {
    static func getPureStringFromBundleResource(_ resource: String, ofType: String) -> String? {
        guard
            let filepath = Bundle.main.path(forResource: resource, ofType: ofType),
            let token = try? String(contentsOfFile: filepath, encoding: .utf8)
            else { return nil }
        return token.filter { !$0.isNewline && !$0.isWhitespace }
    }
}
