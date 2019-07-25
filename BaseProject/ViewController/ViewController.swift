//
//  ViewController.swift
//  BaseProject
//
//  Created by leedongseok on 12/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class ViewController: UIViewController {
    private let viewModel = ViewModel()
    
    // MARK: View switching
    
    private lazy var customView: GitHubView = {
        let view = GitHubView()
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = customView
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        title = ViewModel.title
        setupRX()
    }
    
    private let disposeBag = DisposeBag()
    private func setupRX() {
        let searchBar = customView.searchController.searchBar
        let tableView = customView.tableView
        
        // MARK: UI
        
        tableView.rx.willDisplayCell.asDriver()
            .drive(onNext: { [weak self] cell, indexPath in
                if tableView.isLastRow(with: indexPath) == true {
                    self?.viewModel.searchGithubUserIfCan(by: searchBar.text, isPagination: true)
                }
            })
            .disposed(by: disposeBag)

        tableView.rx.contentOffset.asDriver()
            .drive(onNext: { offset in
                if searchBar.isFirstResponder {
                    searchBar.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
                
        searchBar.rx.text.orEmpty.asDriver()
            .throttle(.milliseconds(1000))
            .distinctUntilChanged()
            .drive(onNext: { [weak self] query in
                self?.viewModel.searchText.accept(query)
            })
            .disposed(by: disposeBag)
 
        searchBar.rx.cancelButtonClicked.asDriver()
            .drive(onNext: { [weak self] _ in
                self?.viewModel.searchText.accept("")
            })
            .disposed(by: disposeBag)

        // MARK: Data
        
        viewModel.searchText
            .bind { [weak self] query in
                guard let viewModel = self?.viewModel else { return }
                viewModel.cancelRequest()
                viewModel.searchGithubUserIfCan(by: query)
            }
            .disposed(by: disposeBag)
 
        viewModel.users
            .bind(to: tableView.rx
                .items(cellIdentifier: "\(GitHubUserCell.self)")) { indexPath, user, cell in
                    guard let cell = cell as? GitHubUserCell else { return }
                    cell.configure(user: user)
            }
            .disposed(by: disposeBag)
    }
}

