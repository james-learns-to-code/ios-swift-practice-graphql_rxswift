//
//  StarwarsNetworkManager.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

final class StarwarsNetworkManager: NetworkManager {
    static let shared = StarwarsNetworkManager()
    
    struct URL {
        static let base = "https://swapi.co/api/"
        static let filmPath = "films/"
        static let film = base + filmPath
    }
}

// MARK: Interface
extension StarwarsNetworkManager {
    func requestFilmList(
        handler: @escaping (Result<StarwarsFilmsModel, Error>) -> Void) {
        request(with: StarwarsNetworkManager.URL.film, type: .get) { result in
            ResultType<StarwarsFilmsModel>
                .handle(result, handler: handler)
        }
    }
}
