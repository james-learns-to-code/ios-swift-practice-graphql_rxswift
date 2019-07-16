//
//  StarwarsFilmsModel.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

struct StarwarsFilmsModel: Codable {
    var results: [StarwarsFilmModel]?
}

struct StarwarsFilmModel: Codable {
    var title: String?
    var episode_id: Int?
    var director: String?
}
