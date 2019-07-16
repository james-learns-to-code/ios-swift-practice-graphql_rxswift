//
//  Binding.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

final class Binding<T> {
    
    private var listner: ((T?) -> Void)?

    var value: T? {
        didSet { listner?(value) }
    }
    
    func bind(listner: ((T?) -> Void)?) {
        self.listner = listner
    }
}
