//
//  StarwarsFilmCell.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

struct StarwarsFilmCellViewModel {
    static func getTitle(from film: StarwarsFilmModel?) -> String {
        return "\(film?.episode_id ?? 0) \(film?.title ?? "") - \(film?.director ?? "")"
    }
}

final class StarwarsFilmCell: UITableViewCell {
    func configure(film: StarwarsFilmModel?) {
        textLabel?.text = StarwarsFilmCellViewModel.getTitle(from: film)
    }
}
