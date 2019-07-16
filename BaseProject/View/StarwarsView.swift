//
//  StarwarsView.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class StarwarsView: UIView {
    
    lazy private var tableView: UITableView = {
        let view = UITableView()
        view.register(StarwarsFilmCell.self, forCellReuseIdentifier: "StarwarsFilmCell")
        return view
    }()
    
    required init(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        super.init(frame: .zero)
        setup()
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup() {
        backgroundColor = .red
        addTableView()
    }
    private func addTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalTo: heightAnchor),
            tableView.widthAnchor.constraint(equalTo: widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
    }
    
    func reload() {
        tableView.reloadData()
    }
}
