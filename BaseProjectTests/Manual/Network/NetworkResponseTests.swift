//
//  NetworkResponseTests.swift
//  BaseProjectTests
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import BaseProject

// MARK: Manual test
class NetworkResponseTests: QuickSpec {
 
    override func spec() {
        
        // MARK: prepare
        let timeout = TimeInterval(5)

        // Network response have to be callback properly
        describe("Network request") {
            context("Starwars api list") {
                it("Have to be callback properly") {
                    waitUntil(timeout: timeout) { done in
                        StarwarsNetworkManager.shared.requestFilmList { result in
                            if case .success = result {} else { fail() }
                            done()
                        }
                    }
                }
            }
        }
    }
}
