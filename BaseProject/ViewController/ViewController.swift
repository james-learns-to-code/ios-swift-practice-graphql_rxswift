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
import Kingfisher

final class ViewController: UIViewController {
    private let viewModel = ViewModel()
    
    // MARK: View switching
    
    private lazy var customView = GitHubView()
    
    override func loadView() {
        super.loadView()
        view = customView
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        title = ViewModel.title
        setupRx()
    }
    
    private let disposeBag = DisposeBag()
    private func setupRx() {
        let searchBar = customView.searchController.searchBar
        let tableView = customView.tableView
        let viewModel = self.viewModel
        
        // UI
        
        tableView.rx.willDisplayCell.asDriver()
            .drive(onNext: {
                cell, indexPath in
                if tableView.isLastRow(with: indexPath) {
                    viewModel.searchMoreGithubUserIfCan(
                        by: searchBar.text)
                }
            })
            .disposed(by: disposeBag)
        
        tableView.rx.prefetchRows
            .subscribe(onNext: { indexPaths in
                let urls = indexPaths.compactMap {
                    viewModel.getAvataUrl(at: $0)
                }
                ImagePrefetcher(urls: urls).start()
            })
            .disposed(by: disposeBag)

        tableView.rx.contentOffset.asDriver()
            .drive(onNext: { offset in
                searchBar.resignFirstResponderIfIs()
            })
            .disposed(by: disposeBag)
                
        searchBar.rx.text.orEmpty.asDriver()
            .debounce(.milliseconds(ViewModel.searchBarDebounceMSec))
            .distinctUntilChanged()
            .drive(onNext: { query in
                viewModel.searchText.accept(query)
            })
            .disposed(by: disposeBag)
 
        searchBar.rx.cancelButtonClicked.asDriver()
            .drive(onNext: { _ in
                viewModel.searchText.accept("")
            })
            .disposed(by: disposeBag)

        // Data
        
        viewModel.searchText
            .bind { [weak viewModel] query in
                viewModel?.searchGithubUserIfCan(by: query)
            }
            .disposed(by: disposeBag)
 
        viewModel.users.asDriver()
            .drive(tableView.rx
                .items(cellIdentifier: "\(GitHubUserCell.self)")) {
                    index, user, cell in
                    let cell = cell as? GitHubUserCell
                    cell?.configure(user: user)
            }
            .disposed(by: disposeBag)
        
        viewModel.error.asDriver(onErrorJustReturn: .undefined)
            .drive(onNext: { [weak self] error in
                let alert = UIAlertController(
                    title: "Error",
                    message: error.localizedDescription,
                    doneButtonTitle: "OK"
                )
                self?.presentedViewController?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

