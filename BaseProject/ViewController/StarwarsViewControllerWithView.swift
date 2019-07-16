//
//  StarwarsViewControllerWithView.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class StarwarsViewControllerWithView: UIViewController {
    private let viewModel = StarwarsViewModel()
    
    lazy private var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(StarwarsFilmCell.self, forCellReuseIdentifier: "StarwarsFilmCell")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.fetchApiList()
    }
    
    // MARK: Setup
    
    private func setup() {
        addTableView()
        setupBinding()
    }
    private func addTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    private func setupBinding() {
        viewModel.films.bind() { [weak self] films in
            DispatchQueue.main.async {
                self?.reload()
            }
        }
    }
    
    private func reload() {
        tableView.reloadData()
    }
}

extension StarwarsViewControllerWithView: UITableViewDelegate {
}

extension StarwarsViewControllerWithView: UITableViewDataSource {
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
