//
//  GitHubUserCell.swift
//  BaseProject
//
//  Created by leedongseok on 18/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit
import SnapKit

struct GitHubUserCellViewModel {
    fileprivate static func getRepositoryDescription(from user: GitHubSearchUserModel?) -> String {
        return "Number of repos: \(user?.repositories?.totalCount ?? 0)"
    }
}

final class GitHubUserCell: UITableViewCell {
    static let height: CGFloat = 80
    
    // MARK: Interface
    func configure(user: GitHubSearchUserModel?) {
        profileImageView.setImageByKF(with: user?.avatarUrl)
        idLabel.text = user?.login
        repoDescriptionLabel.text = GitHubUserCellViewModel.getRepositoryDescription(from: user)
    }
    
    // MARK: UI
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var idLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var repoDescriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .gray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.leading.top.equalTo(self).inset(10)
        }
        addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.equalTo(self).inset(80)
            make.top.trailing.equalTo(self).inset(10)
        }
        addSubview(repoDescriptionLabel)
        repoDescriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.equalTo(self).inset(80)
            make.bottom.trailing.equalTo(self).inset(10)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
