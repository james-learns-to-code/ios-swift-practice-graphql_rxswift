//
//  GitHubUserCell.swift
//  BaseProject
//
//  Created by leedongseok on 18/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit
import Kingfisher

struct GitHubUserCellViewModel {
    static func getAvataUrl(from user: GitHubSearchUserModel?) -> URL? {
        guard let avatarUrlString = user?.avatarUrl else { return nil }
        return URL(string: avatarUrlString)
    }
    static func getRepositoryDescription(from user: GitHubSearchUserModel?) -> String {
        return "Number of repos: \(user?.repository?.totalCount ?? 0))"
    }
}

final class GitHubUserCell: UITableViewCell {
    func configure(user: GitHubSearchUserModel?) {
        imageView?.kf.setImage(with: GitHubUserCellViewModel.getAvataUrl(from: user))
        textLabel?.text = user?.name
        detailTextLabel?.text = GitHubUserCellViewModel.getRepositoryDescription(from: user)
    }
}
