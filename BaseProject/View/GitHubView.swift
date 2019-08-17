//
//  GitHubView.swift
//  BaseProject
//
//  Created by leedongseok on 18/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit
import Then
import SnapKit
import SwiftUtilityKit

final class GitHubView: UIView {
    
    lazy var tableView = UITableView().then { view in
        view.register(GitHubUserCell.self)
        view.rowHeight = GitHubUserCell.height
        view.contentInset.bottom = CGFloat(ViewModel.bottomInset)
    }
    
    lazy var searchController =
        UISearchController(searchResultsController: nil).then { ctr in
            ctr.hidesNavigationBarDuringPresentation = false
            ctr.dimsBackgroundDuringPresentation = false
    }
    
    required init() {
        super.init(frame: .zero)
        setup()
    }
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        addSubview(tableView) { make in
            make.edges.equalToSuperview()
        }
        tableView.tableHeaderView = searchController.searchBar
    }
}
