//
//  CollectionExtension.swift
//  BaseProject
//
//  Created by leedongseok on 18/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
