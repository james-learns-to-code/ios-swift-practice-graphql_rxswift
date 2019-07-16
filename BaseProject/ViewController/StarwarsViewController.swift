//
//  StarwarsViewController.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class StarwarsViewController: UIViewController {
    private let viewModel = StarwarsViewModel()
    
    // MARK: View switching
    
    private lazy var customView: StarwarsView = {
        let view = StarwarsView(delegate: self, dataSource: self)
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
        viewModel.fetchApiList()
    }
    
    // MARK: Setup
    
    private func setup() {
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel.films.bind() { [weak self] films in
            DispatchQueue.main.async {
                self?.customView.reload()
            }
        }
    }
}

extension StarwarsViewController: UITableViewDelegate {
}

extension StarwarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StarwarsFilmCell", for: indexPath) as! StarwarsFilmCell
        let film = viewModel.film(at: indexPath)
        cell.configure(film: film)
        return cell
    }
}
