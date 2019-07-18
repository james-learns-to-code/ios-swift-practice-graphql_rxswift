//
//  ViewController.swift
//  BaseProject
//
//  Created by leedongseok on 12/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit
import SwiftUtilityKit

final class ViewController: UIViewController {
    private let viewModel = ViewModel()
    
    // MARK: View switching
    
    private lazy var customView: GitHubView = {
        let view = GitHubView(delegate: self, dataSource: self)
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.fetchUserList()
    }
    
    // MARK: Setup
    
    private func setup() {
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel.users.bind() { [weak self] users in
            DispatchQueue.main.async {
                self?.customView.reload()
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GitHubUserCell.dequeue(from: tableView, for: indexPath)!
        let user = viewModel.user(at: indexPath)
        cell.configure(user: user)
        return cell
    }
}
