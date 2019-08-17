//
//  GitHubUserCell.swift
//  BaseProject
//
//  Created by leedongseok on 18/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit
import Then
import SnapKit

struct GitHubUserCellViewModel {
    fileprivate static func getRepoDescription(
        from user: GitHubSearchUserModel?) -> String {
        let count = user?.repositories?.totalCount ?? 0
        return "Number of repos: \(count)"
    }
}

final class GitHubUserCell: UITableViewCell {
    typealias ViewModel = GitHubUserCellViewModel
    static let height: CGFloat = 80
    
    // MARK: Interface
    func configure(user: GitHubSearchUserModel?) {
        profileImageView.setImageByKF(with: user?.avatarUrl)
        idLabel.text = user?.login
        repoLabel.text = ViewModel.getRepoDescription(from: user)
    }
    
    // MARK: UI
    
    private lazy var profileImageView = UIImageView()
    private lazy var idLabel = UILabel()
    private lazy var repoLabel = UILabel().then { view in
        view.textColor = .gray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView) { make in
            make.width.height.equalTo(60)
            make.leading.top.equalTo(self).inset(10)
        }
        addSubview(idLabel) { make in
            make.height.equalTo(30)
            make.leading.equalTo(self).inset(80)
            make.top.trailing.equalTo(self).inset(10)
        }
        addSubview(repoLabel) { make in
            make.height.equalTo(30)
            make.leading.equalTo(self).inset(80)
            make.bottom.trailing.equalTo(self).inset(10)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
